import 'package:fake_news/core/api/auth_api.dart';
import 'package:fake_news/core/api/news_community_api.dart';
import 'package:fake_news/core/base/base_view_model.dart';
import 'package:fake_news/models/language_model.dart';
import 'package:fake_news/models/news_comnunity_model.dart';
import 'package:fake_news/providers/auth_repo.dart';
import 'package:fake_news/resources/utils/app_config.dart';
import 'package:fake_news/resources/utils/app_constant.dart';
import 'package:fake_news/resources/widgets/snackbar_custom.dart';
import 'package:fake_news/services/language_service/language_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ContributeViewModel extends BaseViewModel {
  ContributeViewModel(
      {required this.newsCommunityApi,
      required this.prefs,
      required this.authApi,
      required this.authRepo,
      required this.languageService,
      required this.appEnvironment});

  NewsCommunityApi newsCommunityApi;
  SharedPreferences prefs;
  AuthApi authApi;
  AuthRepo authRepo;
  AppEnvironment appEnvironment;

  var titleController = TextEditingController();
  var contentController = TextEditingController();
  var languagesList = Get.find<List<LanguageModel>?>();
  LanguageService languageService;

  var selectedValue = 0.obs;
  var getLanguageContent = "".obs, tempLanguageContent = "".obs;

  void clearText() {
    titleController.clear();
    contentController.clear();
  }

  bool _validateTextField() {
    if (titleController.text.isEmpty) {
      _showSnackbar("inputTitleEmptyErr".tr);
      return false;
    }
    if (contentController.text.isEmpty) {
      _showSnackbar("inputContentEmptyErr".tr);
      return false;
    }
    return true;
  }

  handleCreate() async {
    if (!_validateTextField()) {
      return;
    }

    EasyLoading.show(status: 'Loading...'.tr);

    var userId = await authRepo.getUserId();
    var user = await authApi.getUserLoggedIn(userId!);
    //this.user?.value = user.resultObj!;

    var languageContent =
        prefs.getString(AppConstant.sharePrefKeys.languageContent);

    var response = await newsCommunityApi.createNewsCommunity(
        titleController.text,
        contentController.text,
        languageContent ?? 'en',
        userId);

    if (response.isSuccessed == false) {
      EasyLoading.dismiss();
      _showSnackbar(response.messages!);
    } else {
      //clear all data before get data from API to avoid duplication
      titleController.clear();
      contentController.clear();
      EasyLoading.dismiss();
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

  @override
  void onInit() async {
    super.onInit();
    await handleCreate();
  }
}
