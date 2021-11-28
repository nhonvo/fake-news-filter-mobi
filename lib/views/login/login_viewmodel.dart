import 'package:fake_news/core/api/auth_api.dart';
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
  var passwordController = TextEditingController();

  void clearText() {
    usernameController.clear();
  }

  handlelogin() async {
    EasyLoading.show(status: 'Logging in...');

    var response = await authApi.login(usernameController.text, passwordController.text);

    if (response.isSuccessed == false) {
      EasyLoading.dismiss();
      snackBar(
        'Error',
        response.messages!,
        'Something went wrong',
        Icon(
          Icons.error,
          color: Colors.white,
        ),
        Colors.red,
        Colors.white,
        SnackPosition.BOTTOM,
      );
    } else {
      LoginModel user = response.resultObj!;
      await authRepo.saveAuthToken(user.token ?? '');
      Get.offAllNamed(Routes.HOME);
      EasyLoading.dismiss();
    }
  }

  handleLoginFacebook() async {
    final LoginResult result = await FacebookAuth.instance
        .login(permissions: ['public_profile', 'email']); // by default we request the email and the public profile

    if (result.status == LoginStatus.success) {
      final AccessToken accessToken = result.accessToken!;

      var response = await authApi.loginFacebook(accessToken.token);
      if (response.isSuccessed == false) {
        EasyLoading.dismiss();
        snackBar(
          'Error',
          response.messages!,
          'Something went wrong',
          Icon(
            Icons.error,
            color: Colors.white,
          ),
          Colors.red,
          Colors.white,
          SnackPosition.BOTTOM,
        );
      } else {
        LoginModel user = response.resultObj!;
        await authRepo.saveAuthToken(user.token ?? '');
        Get.offAllNamed(Routes.HOME);
        EasyLoading.dismiss();
      }
    } else {
      print(result.status);
      print(result.message);
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
    try {
      var result = await _googleSignIn.signIn();
      GoogleSignInAuthentication googleSignInAuthentication = await result!.authentication;

      var response = await authApi.loginGoogle(googleSignInAuthentication.idToken.toString());
      if (response.isSuccessed == false) {
        EasyLoading.dismiss();
        snackBar(
          'Error',
          response.messages!,
          'Something went wrong',
          Icon(
            Icons.error,
            color: Colors.white,
          ),
          Colors.red,
          Colors.white,
          SnackPosition.BOTTOM,
        );
      } else {
        LoginModel user = response.resultObj!;
        await authRepo.saveAuthToken(user.token ?? '');
        Get.offAllNamed(Routes.HOME);
        EasyLoading.dismiss();
      }
    } catch (error) {
      print(error);
    }
  }
}
