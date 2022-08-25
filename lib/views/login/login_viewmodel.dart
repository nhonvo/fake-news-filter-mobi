import 'package:fake_news/core/api/auth_api.dart';
import 'package:fake_news/core/api/following_api.dart';
import 'package:fake_news/core/base/base_view_model.dart';
import 'package:fake_news/models/users/login_model.dart';
import 'package:fake_news/providers/local_storage_repo.dart';
import 'package:fake_news/resources/utils/app_routes.dart';
import 'package:fake_news/resources/widgets/snackbar_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class LoginViewModel extends BaseViewModel {
  LoginViewModel(
      {required this.authApi, required this.localRepo, required this.pref});
  AuthApi authApi;
  LocalStorageRepo localRepo;
  SharedPreferences pref;

  var usernameController = TextEditingController();
  var usernameRegController = TextEditingController();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var passwordRegController = TextEditingController();
  var passwordConfirmRegController = TextEditingController();

  FollowingApi followingApi = Get.find();

  void clearText() {
    usernameController.clear();
  }

  bool _validateTextField() {
    if (usernameController.text.isEmpty) {
      SnackbarCustom.showError(
        message: "inputUserEmptyErr".tr,
        altMessage: 'altMessage'.tr,
      );
      return false;
    }
    if (passwordController.text.isEmpty) {
      SnackbarCustom.showError(
        message: "inputPassEmptyErr".tr,
        altMessage: 'altMessage'.tr,
      );
      return false;
    }
    if (passwordController.text.length < 6) {
      SnackbarCustom.showError(
        message: "inputPassAtLeast6Err".tr,
        altMessage: 'altMessage'.tr,
      );
      return false;
    }
    return true;
  }

  handleLogin() async {
    if (!_validateTextField()) {
      return;
    }

    EasyLoading.show(status: 'loadingLogin'.tr);

    var response =
        await authApi.login(usernameController.text, passwordController.text);

    if (response.statusCode != 200) {
      EasyLoading.dismiss();
      SnackbarCustom.showError(
        message: response.message!,
        altMessage: 'altMessage'.tr,
      );
    } else {
      _checkIsFollowed(response);
    }
  }

  //Đăng ký thành viên mới
  handleRegister() async {
    try {
      var response = await authApi.register({
        "username": usernameRegController.text,
        "name": nameController.text,
        "email": emailController.text,
        "password": passwordRegController.text,
        "confirmPassword": passwordConfirmRegController.text,
      });

      if (response.statusCode != 200) {
        SnackbarCustom.showError(
          message: response.message!,
          altMessage: 'altMessage'.tr,
        );
      } else {
        SnackbarCustom.showError(
          message: 'succRegister'.tr,
          altMessage: 'success'.tr,
        );
        Get.toNamed(Routes.LOGIN, arguments: 'havebtnBack');
      }
    } catch (error) {
      SnackbarCustom.showError(
        message: 'errRegister'.tr,
        altMessage: 'altMessage'.tr,
      );
    }
  }

  //Đăng nhập bằng Facebook
  handleLoginFacebook() async {
    EasyLoading.show(status: 'loadingLogin'.tr);

    final LoginResult result = await FacebookAuth.instance.login(permissions: [
      'public_profile',
      'email'
    ]); // by default we request the email and the public profile

    if (result.status == LoginStatus.success) {
      final AccessToken accessToken = result.accessToken!;

      var response = await authApi.loginFacebook(accessToken.token);
      if (response.statusCode != 200) {
        EasyLoading.dismiss();
        SnackbarCustom.showError(
          message: 'errLogFace'.tr,
          altMessage: 'altMessage'.tr,
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {
        _checkIsFollowed(response);
      }
    } else {
      SnackbarCustom.showError(
        message: 'errLogFace'.tr,
        altMessage: 'altMessage'.tr,
      );
      EasyLoading.dismiss();
    }
  }

  //Đăng nhập bằng Apple
  handleLoginApple() async {
    try {
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName
        ],
      );
      String fullName = '${credential.familyName}' + '${credential.givenName}';

      var response = await authApi.loginApple(
          fullName, credential.identityToken.toString());

      if (response.statusCode != 200) {
        EasyLoading.dismiss();
        SnackbarCustom.showError(
          message: 'errLogApple'.tr,
          altMessage: 'altMessage'.tr,
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {
        _checkIsFollowed(response);
      }
    } catch (error) {
      SnackbarCustom.showError(
        message: 'errLogApple'.tr,
        altMessage: 'altMessage'.tr,
      );
    }
  }

  //Đăng nhập bằng Google
  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email', "https://www.googleapis.com/auth/userinfo.profile"],
  );

  handleLoginGoogle() async {
    EasyLoading.show(status: 'loadingLogin'.tr);

    try {
      var result = await _googleSignIn.signIn();
      GoogleSignInAuthentication googleSignInAuthentication =
          await result!.authentication;

      var response = await authApi
          .loginGoogle(googleSignInAuthentication.idToken.toString());
      if (response.statusCode != 200) {
        EasyLoading.dismiss();
        SnackbarCustom.showError(
          message: 'errLogGoogle'.tr,
          altMessage: 'altMessage'.tr,
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {
        _checkIsFollowed(response);
      }
    } catch (error) {
      EasyLoading.dismiss();
      SnackbarCustom.showError(
        message: 'errLogGoogle'.tr,
        altMessage: 'altMessage'.tr,
      );
    }
  }

  _checkIsFollowed(dynamic response) async {
    LoginModel user = response.resultObj!;

    await localRepo.saveAuthToken(user.token ?? '');
    await localRepo.saveUserId(user.userId!);

    //check if user has followed any topic
    var topicIdList =
        await followingApi.getFollowedTopic(user.userId.toString());
    bool isNotFollow =
        topicIdList.resultObj == null || topicIdList.resultObj?.length == 0;

    if (isNotFollow) {
      EasyLoading.dismiss();
      Get.offAllNamed(Routes.FOLLOW_TOPIC);
    } else {
      EasyLoading.dismiss();
      //set this user has followed any topics
      await localRepo.saveIsNotFollow(false);
      Get.offAllNamed(Routes.HOME);
    }
  }
}
