import 'package:dio/dio.dart' as dio;
import 'package:fake_news/core/api/auth_api.dart';
import 'package:fake_news/core/api/following_api.dart';
import 'package:fake_news/core/base/base_view_model.dart';
import 'package:fake_news/models/users/login_model.dart';
import 'package:fake_news/providers/auth_repo.dart';
import 'package:fake_news/resources/utils/app_routes.dart';
import 'package:fake_news/resources/widgets/snackbar_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginViewModel extends BaseViewModel {
  LoginViewModel({required this.authApi, required this.authRepo, required this.pref});
  AuthApi authApi;
  AuthRepo authRepo;
  SharedPreferences pref;

  var usernameController = TextEditingController();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();
  var passwordConfirmController = TextEditingController();
  FollowingApi followingApi = Get.find();

  void clearText() {
    usernameController.clear();
  }

  bool _validateTextField() {
    if (usernameController.text.isEmpty) {
      _showSnackbar("inputUserEmptyErr".tr);
      return false;
    }
    if (passwordController.text.isEmpty) {
      _showSnackbar("inputPassEmptyErr".tr);
      return false;
    }
    if (passwordController.text.length < 6) {
      _showSnackbar("inputPassAtLeast6Err".tr);
      return false;
    }
    return true;
  }

  handleLogin() async {
    if (!_validateTextField()) {
      return;
    }

    EasyLoading.show(status: 'loadingLogin'.tr);

    var response = await authApi.login(usernameController.text, passwordController.text);

    if (response.isSuccessed == false) {
      EasyLoading.dismiss();
      _showSnackbar(response.messages!);
    } else {
      _checkIsFollowed(response);
    }
  }

  handleRegister() async {
    var response = await authApi.register({
      "username": usernameController.text,
      "name": nameController.text,
      "email": emailController.text,
      "phoneNumber": phoneController.text,
      "password": passwordController.text,
      "confirmPassword": passwordConfirmController.text,
    });

    if (response.isSuccessed == false) {
      _showSnackbar(response.messages ?? "An error occurred");
    } else {
      _showSnackbar(response.messages!);
    }
  }

  handleLoginFacebook() async {
    EasyLoading.show(status: 'loadingLogin'.tr);

    final LoginResult result = await FacebookAuth.instance
        .login(permissions: ['public_profile', 'email']); // by default we request the email and the public profile

    if (result.status == LoginStatus.success) {
      final AccessToken accessToken = result.accessToken!;

      var response = await authApi.loginFacebook(accessToken.token);
      if (response.isSuccessed == false) {
        EasyLoading.dismiss();
        _showSnackbar(response.messages!);
      } else {
        _checkIsFollowed(response);
      }
    } else {
      _showSnackbar(result.message!);
      EasyLoading.dismiss();
    }
  }

  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
      "https://www.googleapis.com/auth/userinfo.profile"
    ],
  );

  handleLoginGoogle() async {
    EasyLoading.show(status: 'loadingLogin'.tr);

    try {
      var result = await _googleSignIn.signIn();
      GoogleSignInAuthentication googleSignInAuthentication = await result!.authentication;

      var response = await authApi.loginGoogle(googleSignInAuthentication.idToken.toString());
      if (response.isSuccessed == false) {
        EasyLoading.dismiss();
        _showSnackbar(response.messages!);
      } else {
        _checkIsFollowed(response);
      }
    } catch (error) {
      EasyLoading.dismiss();
      _showSnackbar(error.toString());
    }
  }

  _checkIsFollowed(dynamic response) async {
    LoginModel user = response.resultObj!;

    await authRepo.saveAuthToken(user.token ?? '');
    await authRepo.saveUserId(user.userId!);

    //check if user has followed any topic
    var topicIdList = await followingApi.getFollowedTopic(user.userId.toString());
    bool isNotFollow = topicIdList.resultObj == null || topicIdList.resultObj?.length == 0;

    if (isNotFollow) {
      EasyLoading.dismiss();
      Get.offAllNamed(Routes.FOLLOW_TOPIC);
    } else {
      EasyLoading.dismiss();
      //set this user has followed any topics
      await authRepo.saveIsNotFollow(false);
      Get.offAllNamed(Routes.HOME);
    }
  }

  _showSnackbar(String message) {
    snackBar(
      'error'.tr,
      message,
      'altMessage'.tr,
      Icon(
        Icons.error,
        color: Colors.white,
      ),
      Colors.red,
      Colors.white,
      SnackPosition.BOTTOM,
    );
  }
}
