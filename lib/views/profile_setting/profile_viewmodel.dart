import 'package:fake_news/core/api/auth_api.dart';
import 'package:fake_news/core/base/base_view_model.dart';
import 'package:fake_news/models/users/user_model.dart';
import 'package:fake_news/providers/auth_repo.dart';
import 'package:fake_news/resources/utils/app_routes.dart';
import 'package:fake_news/resources/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileViewModel extends BaseViewModel {
  ProfileViewModel({required this.authApi, required this.authRepo, required this.pref});
  AuthApi authApi;
  AuthRepo authRepo;
  SharedPreferences pref;

  Rx<UserModel>? user = Rx<UserModel>(new UserModel());

  getLoggedInUser() async {
    var userId = await authRepo.getUserId();
    var user = await authApi.getUserLoggedIn(userId!);
    this.user?.value = user.resultObj!;
  }

  handleLogout() async {
    Get.defaultDialog(
      title: "logout".tr,
      titleStyle: StylesText.content14BoldBlack,
      middleText: "confirmLogout".tr,
      middleTextStyle: StylesText.content12BoldBlack,
      barrierDismissible: false,
      radius: 15.0,
      confirm: confirmBtn(),
      cancel: cancelBtn(),
    );
  }

  @override
  void onInit() async {
    super.onInit();
    await getLoggedInUser();
  }

  Widget confirmBtn() {
    return ElevatedButton(
        onPressed: () {
          authRepo.handleUnAuthorized();
          Get.offAllNamed(Routes.DISCOVERY);
        },
        child: Text("okay".tr));
  }

  Widget cancelBtn() {
    return ElevatedButton(
        onPressed: () {
          Get.back();
        },
        child: Text("cancel".tr));
  }
}
