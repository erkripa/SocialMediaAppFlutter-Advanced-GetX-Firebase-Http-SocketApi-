import 'dart:async';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:social_media_app/apis/models/entities/post.dart';
import 'package:social_media_app/apis/models/responses/common_response.dart';
import 'package:social_media_app/apis/models/responses/post_details_response.dart';
import 'package:social_media_app/apis/providers/api_provider.dart';
import 'package:social_media_app/app_services/auth_service.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/modules/home/controllers/profile_controller.dart';
import 'package:social_media_app/routes/route_management.dart';
import 'package:social_media_app/services/hive_service.dart';
import 'package:social_media_app/utils/utility.dart';

class PostDetailsController extends GetxController {
  static PostDetailsController get find => Get.find();

  final _auth = AuthService.find;
  final _apiProvider = ApiProvider(http.Client());

  final _isLoading = false.obs;
  final _postDetailsData = const PostDetailsResponse().obs;
  final _postId = ''.obs;

  /// Getters
  bool get isLoading => _isLoading.value;

  PostDetailsResponse? get postDetailsData => _postDetailsData.value;

  String? get postId => _postId.value;

  /// Setters
  set setPostDetailsData(PostDetailsResponse response) {
    _postDetailsData.value = response;
  }

  @override
  void onInit() {
    super.onInit();

    _postId.value = Get.arguments[0];
    Post? post = Get.arguments[1];

    if (post != null) {
      if (_postId.value.isEmpty) {
        _postId.value = post.id!;
      }
      setPostDetailsData = PostDetailsResponse(success: true, post: post);
      update();
    }

    if (_postId.value.isNotEmpty) {
      _fetchPostDetails();
    }
  }

  Future<void> _fetchPostDetails() async {
    if (_postId.value == '' || _postId.value.isEmpty) return;

    _isLoading.value = true;
    update();

    try {
      final response =
          await _apiProvider.getPostDetails(_auth.token, _postId.value);

      if (response.isSuccessful) {
        final decodedData = response.data;
        setPostDetailsData = PostDetailsResponse.fromJson(decodedData);
        _isLoading.value = false;
        update();
      } else {
        final decodedData = response.data;
        _isLoading.value = false;
        update();
        AppUtility.showSnackBar(
          decodedData[StringValues.message],
          StringValues.error,
        );
      }
    } catch (exc) {
      _isLoading.value = false;
      update();
      AppUtility.showSnackBar('Error: ${exc.toString()}', StringValues.error);
    }
  }

  Future<void> _deletePost(String postId) async {
    RouteManagement.goToBack();

    try {
      final response = await _apiProvider.deletePost(_auth.token, postId);

      if (response.isSuccessful) {
        final decodedData = response.data;
        final apiResponse = CommonResponse.fromJson(decodedData);
        AppUtility.showSnackBar(
          apiResponse.message!,
          StringValues.success,
        );
      } else {
        final decodedData = response.data;
        final apiResponse = CommonResponse.fromJson(decodedData);
        await HiveService.delete<Post>('profilePosts', postId);
        await ProfileController.find.fetchProfileDetails(fetchPost: true);
        update();
        AppUtility.showSnackBar(
          apiResponse.message!,
          StringValues.error,
        );
      }
    } catch (exc) {
      update();
      AppUtility.log('Error: ${exc.toString()}', tag: 'error');
      AppUtility.showSnackBar('Error: ${exc.toString()}', StringValues.error);
    }
  }

  void _toggleLike(Post post) {
    if (post.isLiked == true) {
      post.isLiked = false;
      post.likesCount = post.likesCount! - 1;
      update();
      return;
    } else {
      post.isLiked = true;
      post.likesCount = post.likesCount! + 1;
      update();
      return;
    }
  }

  Future<void> _toggleLikePost(Post post) async {
    _toggleLike(post);

    try {
      final response = await _apiProvider.likeUnlikePost(_auth.token, post.id!);

      if (response.isSuccessful) {
        final decodedData = response.data;
        final apiResponse = CommonResponse.fromJson(decodedData);
        AppUtility.log(apiResponse.message!);
      } else {
        _toggleLike(post);
        final decodedData = response.data;
        final apiResponse = CommonResponse.fromJson(decodedData);
        AppUtility.showSnackBar(
          apiResponse.message!,
          StringValues.error,
        );
      }
    } catch (exc) {
      _toggleLike(post);
      AppUtility.log('Error: ${exc.toString()}', tag: 'error');
      AppUtility.showSnackBar('Error: ${exc.toString()}', StringValues.error);
    }
  }

  void _castVote(Post post, String optionId) {
    if (post.isVoted == true) {
      post.votedOption = null;
      post.isVoted = false;
      post.totalVotes = post.totalVotes! - 1;
      for (var element in post.pollOptions!) {
        if (element.id == post.votedOption) {
          element.votes = element.votes! - 1;
        }
      }
      update();
      return;
    }

    post.votedOption = optionId;
    post.isVoted = true;
    post.totalVotes = post.totalVotes! + 1;
    for (var element in post.pollOptions!) {
      if (element.id == optionId) {
        element.votes = element.votes! + 1;
      }
    }
    update();
  }

  Future<void> _voteToPoll(Post post, String optionId) async {
    _castVote(post, optionId);

    var body = {
      'pollId': post.id!,
      'optionId': optionId,
    };

    try {
      final response = await _apiProvider.voteToPoll(_auth.token, body);

      if (response.isSuccessful) {
        final decodedData = response.data;
        final apiResponse = CommonResponse.fromJson(decodedData);
        AppUtility.log(apiResponse.message!);
      } else {
        _castVote(post, optionId);
        final decodedData = response.data;
        final apiResponse = CommonResponse.fromJson(decodedData);
        AppUtility.showSnackBar(
          apiResponse.message!,
          StringValues.error,
        );
      }
    } catch (exc) {
      _castVote(post, optionId);
      AppUtility.showSnackBar('Error: ${exc.toString()}', StringValues.error);
    }
  }

  Future<void> deletePost(String postId) async => await _deletePost(postId);

  Future<void> toggleLikePost(Post post) async => await _toggleLikePost(post);

  Future<void> fetchPostDetails() async => await _fetchPostDetails();

  Future<void> voteToPoll(Post post, String optionId) async =>
      await _voteToPoll(post, optionId);
}
