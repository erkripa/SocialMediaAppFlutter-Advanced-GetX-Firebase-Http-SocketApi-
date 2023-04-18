import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:social_media_app/apis/models/entities/post.dart';
import 'package:social_media_app/apis/models/responses/common_response.dart';
import 'package:social_media_app/apis/models/responses/post_response.dart';
import 'package:social_media_app/apis/providers/api_provider.dart';
import 'package:social_media_app/app_services/auth_service.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/modules/home/controllers/profile_controller.dart';
import 'package:social_media_app/services/hive_service.dart';
import 'package:social_media_app/utils/utility.dart';

class TrendingPostController extends GetxController {
  static TrendingPostController get find => Get.find();

  final _auth = AuthService.find;
  final _apiProvider = ApiProvider(http.Client());

  final _isLoading = false.obs;
  final _isMoreLoading = false.obs;
  final _postData = PostResponse().obs;

  final searchTextController = TextEditingController();

  final List<Post> _postList = [];

  bool get isLoading => _isLoading.value;

  bool get isMoreLoading => _isMoreLoading.value;

  PostResponse? get postData => _postData.value;

  List<Post> get postList => _postList;

  set setPostData(PostResponse value) => _postData.value = value;

  @override
  void onInit() {
    super.onInit();
    _getData();
  }

  _getData() async {
    _isLoading.value = true;
    update();
    var isExists = await HiveService.hasLength<Post>('trendingPosts');
    if (isExists) {
      var data = await HiveService.getAll<Post>('trendingPosts');
      data.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
      _postList.clear();
      _postList.addAll(data.toList());
    }
    _isLoading.value = false;
    update();
    await _fetchTrendingPosts();
  }

  Future<void> _fetchTrendingPosts() async {
    _isLoading.value = true;
    update();

    try {
      final response = await _apiProvider.getTrendingPosts(_auth.token);

      if (response.isSuccessful) {
        final decodedData = response.data;
        setPostData = PostResponse.fromJson(decodedData);
        _postList.clear();
        _postList.addAll(_postData.value.results!);
        for (var item in _postData.value.results!) {
          await HiveService.put<Post>(
            'trendingPosts',
            item.id,
            item,
          );
        }
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

  Future<void> _loadMore({int? page}) async {
    _isMoreLoading.value = true;
    update();

    try {
      final response =
          await _apiProvider.getTrendingPosts(_auth.token, page: page);

      if (response.isSuccessful) {
        final decodedData = response.data;
        setPostData = PostResponse.fromJson(decodedData);
        _postList.addAll(_postData.value.results!);
        for (var item in _postData.value.results!) {
          await HiveService.put<Post>(
            'trendingPosts',
            item.id,
            item,
          );
        }
        _isMoreLoading.value = false;
        update();
      } else {
        final decodedData = response.data;
        _isMoreLoading.value = false;
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
    if (postId.isEmpty) return;

    var postIndex = _postList.indexWhere((element) => element.id == postId);
    var post = _postList[postIndex];
    if (postIndex == -1) return;

    _postList.removeAt(postIndex);
    update();

    try {
      final response = await _apiProvider.deletePost(_auth.token, postId);

      if (response.isSuccessful) {
        final decodedData = response.data;
        final apiResponse = CommonResponse.fromJson(decodedData);
        await HiveService.delete<Post>('trendingPosts', postId);
        await HiveService.delete<Post>('profilePosts', postId);
        await ProfileController.find.fetchProfileDetails(fetchPost: true);
        AppUtility.showSnackBar(
          apiResponse.message!,
          StringValues.success,
        );
      } else {
        final decodedData = response.data;
        final apiResponse = CommonResponse.fromJson(decodedData);
        _postList.insert(postIndex, post);
        update();
        AppUtility.showSnackBar(
          apiResponse.message!,
          StringValues.error,
        );
      }
    } catch (exc) {
      _postList.insert(postIndex, post);
      update();
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
      AppUtility.showSnackBar('Error: ${exc.toString()}', StringValues.error);
    }
  }

  Future<void> _searchPosts(String searchText) async {
    if (searchText.isEmpty) {
      await _fetchTrendingPosts();
      return;
    }

    _isLoading.value = true;
    update();

    try {
      final response = await _apiProvider.searchPosts(_auth.token, searchText);

      if (response.isSuccessful) {
        final decodedData = response.data;
        setPostData = PostResponse.fromJson(decodedData);
        _postList.clear();
        _postList.addAll(_postData.value.results!);
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

  Future<void> fetchPosts() async => await _fetchTrendingPosts();

  Future<void> searchPosts(String searchText) async =>
      await _searchPosts(searchText);

  Future<void> loadMore() async =>
      await _loadMore(page: _postData.value.currentPage! + 1);

  Future<void> deletePost(String postId) async => await _deletePost(postId);

  Future<void> toggleLikePost(Post post) async => await _toggleLikePost(post);

  Future<void> voteToPoll(Post post, String optionId) async =>
      await _voteToPoll(post, optionId);
}
