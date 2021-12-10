import 'package:fake_news/core/api/auth_api.dart';
import 'package:fake_news/core/base/base_view_model.dart';
import 'package:fake_news/providers/auth_repo.dart';
import 'package:fake_news/resources/utils/app_routes.dart';
import 'package:fake_news/resources/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileViewModel extends BaseViewModel {
  ProfileViewModel(
      {required this.authApi, required this.authRepo, required this.pref});
  AuthApi authApi;
  AuthRepo authRepo;
  SharedPreferences pref;

  handlelogout() async {
    Get.defaultDialog(
      title: "Logout",
      titleStyle: StylesText.content14BoldBlack,
      middleText: "You content goes here...",
      middleTextStyle: StylesText.content12BoldBlack,
      barrierDismissible: false,
      radius: 15.0,
      confirm: confirmBtn(),
      cancel: cancelBtn(),
    );
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  Widget confirmBtn() {
    return ElevatedButton(
        onPressed: () {
          authRepo.handleUnAuthorized();
          Get.offAllNamed(Routes.DISCOVERY);
        },
        child: Text("Confirm"));
  }

  Widget cancelBtn() {
    return ElevatedButton(
        onPressed: () {
          Get.back();
        },
        child: Text("Cancel"));
  }
}
