import 'package:fake_news/core/api/following_api.dart';
import 'package:fake_news/core/api/news_community_api.dart';
import 'package:fake_news/core/api/topic_api.dart';
import 'package:fake_news/core/base/base_view_model.dart';
import 'package:fake_news/models/news_comnunity_model.dart';
import 'package:fake_news/services/language_service/language_service.dart';
import 'package:fake_news/models/language_model.dart';
import 'package:fake_news/providers/local_storage_repo.dart';
import 'package:fake_news/resources/utils/app_config.dart';
import 'package:fake_news/resources/utils/app_constant.dart';
import 'package:fake_news/resources/widgets/snackbar_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CommunityViewModel extends BaseViewModel {
  CommunityViewModel(
      {required this.topicApi,
      required this.followingApi,
      required this.newsCommunityApi,
      required this.languageService,
      required this.localRepo,
      required this.prefs,
      required this.appEnvironment});

  TopicApi topicApi;
  FollowingApi followingApi;
  NewsCommunityApi newsCommunityApi;
  LocalStorageRepo localRepo;
  SharedPreferences prefs;
  AppEnvironment appEnvironment;

  final newsCommList = <NewsCommunityModel>[].obs;
  var topicIds = <int>[].obs;

//used to choose the language in choose language screen
  var languagesList = Get.find<List<LanguageModel>?>();
  LanguageService languageService;

  var selectedValue = 0.obs;
  var getLanguageContent = "".obs, tempLanguageContent = "".obs;
////////////////////////////////////////////////////////////

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  void onRefresh() async {
    // monitor network fetch
    await handleGetNews();
    // if failed,use refreshFailed()
    refreshController.refreshCompleted();
  }

  handleGetNews() async {
    EasyLoading.show(status: 'fetchingData'.tr);

    var languageContent =
        prefs.getString(AppConstant.sharePrefKeys.languageContent);

    var response =
        await newsCommunityApi.getNewsCommunity(languageContent ?? 'en');

    if (response.statusCode != 200) {
      EasyLoading.dismiss();
      SnackbarCustom.showError(
        message: response.message!,
        altMessage: 'altMessage'.tr,
      );
    } else {
      List<NewsCommunityModel> newsCommunityList = response.resultObj!.obs;
      //clear all data before get data from API to avoid duplication
      newsCommList.clear();
      newsCommList.addAll(newsCommunityList);
      EasyLoading.dismiss();
    }
  }

  @override
  void onInit() {
    super.onInit();
    handleGetNews();
  }
}
