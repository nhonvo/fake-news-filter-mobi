import 'package:fake_news/core/api/auth_api.dart';
import 'package:fake_news/core/api/following_api.dart';
import 'package:fake_news/core/base/base_view_model.dart';
import 'package:fake_news/models/users/login_model.dart';
import 'package:fake_news/providers/auth_repo.dart';
import 'package:fake_news/resources/utils/app_routes.dart';
import 'package:fake_news/resources/widgets/snackbar_custom.dart';
import 'package:fake_news/views/get_started/started_screen.dart';
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
  var passwordController = TextEditingController();
  FollowingApi followingApi = Get.find();

  void clearText() {
    usernameController.clear();
  }

  bool validateTextField() {
    if (usernameController.text.isEmpty) {
      showSnackbar("Please fill username field");
      return false;
    }
    if (passwordController.text.isEmpty) {
      showSnackbar("Please fill password field");
      return false;
    }
    if (passwordController.text.length < 6) {
      showSnackbar("Password at lease 6 characters");
      return false;
    }
    return true;
  }

  handlelogin() async {
    if (!validateTextField()) {
      return;
    }

    EasyLoading.show(status: 'loadingLogin'.tr);

    var response = await authApi.login(usernameController.text, passwordController.text);

    if (response.isSuccessed == false) {
      EasyLoading.dismiss();
      showSnackbar(response.messages!);
    } else {
      LoginModel user = response.resultObj!;

      await authRepo.saveAuthToken(user.token ?? '');
      await authRepo.saveUserId(user.userId!);

      var topicIdList = await followingApi.getFollowedTopic(user.userId.toString());

      //check if user has followed any topic
      if (topicIdList.resultObj == null || topicIdList.resultObj?.length == 0) {
        EasyLoading.dismiss();
        Get.offAllNamed(Routes.LAUNCH);
      } else {
        EasyLoading.dismiss();
        Get.offAllNamed(Routes.HOME);
      }
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
        showSnackbar(response.messages!);
      } else {
        LoginModel user = response.resultObj!;
        await authRepo.saveAuthToken(user.token ?? '');
        await authRepo.saveEmail(user.email ?? '');
        Get.offAllNamed(Routes.HOME);
        EasyLoading.dismiss();
      }
    } else {
      showSnackbar(result.message!);
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

  Future<void> handleLoginGoogle() async {
    EasyLoading.show(status: 'loadingLogin'.tr);

    try {
      var result = await _googleSignIn.signIn();
      GoogleSignInAuthentication googleSignInAuthentication = await result!.authentication;

      var response = await authApi.loginGoogle(googleSignInAuthentication.idToken.toString());
      if (response.isSuccessed == false) {
        EasyLoading.dismiss();
        showSnackbar(response.messages!);
      } else {
        LoginModel user = response.resultObj!;
        await authRepo.saveAuthToken(user.token ?? '');
        await authRepo.saveEmail(user.email ?? '');
        Get.offAllNamed(Routes.HOME);
        EasyLoading.dismiss();
      }
    } catch (error) {
      EasyLoading.dismiss();
      showSnackbar(error.toString());
    }
  }

  void showSnackbar(String message) {
    snackBar(
      'error'.tr,
      message,
      'Something went wrong',
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
