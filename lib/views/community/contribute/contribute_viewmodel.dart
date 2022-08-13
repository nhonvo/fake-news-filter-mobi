/*
import 'package:fake_news/core/api/auth_api.dart';
import 'package:fake_news/core/api/news_community_api.dart';
import 'package:fake_news/core/base/base_view_model.dart';
import 'package:fake_news/models/language_model.dart';
import 'package:fake_news/providers/local_storage_repo.dart';
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
      required this.localRepo,
      required this.languageService,
      required this.appEnvironment});

  NewsCommunityApi newsCommunityApi;
  SharedPreferences prefs;
  AuthApi authApi;
  LocalStorageRepo localRepo;
  AppEnvironment appEnvironment;

  var titleController = TextEditingController();
  var contentController = TextEditingController();
  var languagesList = Get.find<List<LanguageModel>?>();
  var resultList = <Asset>[];

  LanguageService languageService;

  var selectedValue = 0.obs;
  var getLanguageContent = "".obs, tempLanguageContent = "".obs;

  void clearText() {
    titleController.clear();
    contentController.clear();
  }

  bool _validateTextField() {
    if (titleController.text.isEmpty) {
      SnackbarCustom.showError(
        message: "inputTitleEmptyErr".tr,
        altMessage: 'altMessage'.tr,
      );
      return false;
    }
    if (contentController.text.isEmpty) {
      SnackbarCustom.showError(
        message: "inputContentEmptyErr".tr,
        altMessage: 'altMessage'.tr,
      );
      return false;
    }
    return true;
  }

  handleCreate() async {
    if (!_validateTextField()) {
      return;
    }

    EasyLoading.show(status: 'Loading...'.tr);

    var userId = await localRepo.getUserId();
    var user = await authApi.getUserLoggedIn(userId!);
    //this.user?.value = user.resultObj!;
    //just the first image in image picker
    var imageFile = resultList[0];
    var languageContent =
        prefs.getString(AppConstant.sharePrefKeys.languageContent);
    var byte = await imageFile.getByteData();
    //convert bytedata to list int
    List<int> imageBytes = byte.buffer
        .asUint8List()
        .map((eachUint8) => eachUint8.toInt())
        .toList();

    var response = await newsCommunityApi.createNewsCommunity(
        titleController.text,
        contentController.text,
        languageContent ?? 'en',
        userId,
        imageBytes,
        imageFile.name ?? 'tmpImage.jpg');

    if (response.statusCode != 200) {
      EasyLoading.dismiss();
      SnackbarCustom.showError(
        message: response.message!,
        altMessage: 'altMessage'.tr,
      );
    } else {
      //clear all data before get data from API to avoid duplication
      titleController.clear();
      contentController.clear();
      EasyLoading.dismiss();
    }
  }

  @override
  void onInit() async {
    super.onInit();
    await handleCreate();
  }
}
*/
