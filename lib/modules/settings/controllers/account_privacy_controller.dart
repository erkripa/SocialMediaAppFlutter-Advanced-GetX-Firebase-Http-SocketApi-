import 'dart:async';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:social_media_app/apis/providers/api_provider.dart';
import 'package:social_media_app/app_services/auth_service.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/modules/home/controllers/profile_controller.dart';
import 'package:social_media_app/utils/utility.dart';

class AccountPrivacyController extends GetxController {
  static AccountPrivacyController get find => Get.find();

  final _profile = ProfileController.find;
  final _auth = AuthService.find;

  final _apiProvider = ApiProvider(http.Client());

  final _isLoading = false.obs;

  bool get isLoading => _isLoading.value;

  Future<void> _changeAccountPrivacy(bool? accountPrivacy) async {
    if (accountPrivacy == null) {
      return;
    }
    AppUtility.printLog(accountPrivacy);

    final body = {'isPrivate': "$accountPrivacy"};

    AppUtility.showLoadingDialog();
    _isLoading.value = true;
    update();

    try {
      final response = await _apiProvider.updateProfile(_auth.token, body);

      if (response.isSuccessful) {
        final decodedData = response.data;
        await _profile.fetchProfileDetails(fetchPost: false);
        AppUtility.closeDialog();
        _isLoading.value = false;
        update();
        AppUtility.showSnackBar(
          decodedData['message'],
          StringValues.success,
        );
      } else {
        final decodedData = response.data;
        AppUtility.closeDialog();
        _isLoading.value = false;
        update();
        AppUtility.showSnackBar(
          decodedData['message'],
          StringValues.error,
        );
      }
    } catch (exc) {
      AppUtility.closeDialog();
      _isLoading.value = false;
      update();
      AppUtility.log('Error: $exc', tag: 'error');
      AppUtility.showSnackBar('Error: $exc', StringValues.error);
    }
  }

  Future<void> changeAccountPrivacy(bool? accountPrivacy) async {
    AppUtility.closeFocus();
    await _changeAccountPrivacy(accountPrivacy);
  }
}
