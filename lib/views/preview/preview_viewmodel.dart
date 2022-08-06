import 'package:fake_news/core/api/following_api.dart';
import 'package:fake_news/core/api/news_api.dart';
import 'package:fake_news/core/base/base_view_model.dart';
import 'package:fake_news/models/news/news_model.dart';
import 'package:fake_news/providers/auth_repo.dart';
import 'package:fake_news/resources/utils/app_config.dart';
import 'package:fake_news/resources/utils/app_routes.dart';
import 'package:fake_news/resources/widgets/snackbar_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PreviewViewModel extends BaseViewModel {
  PreviewViewModel(
      {required this.newsApi,
      required this.followingApi,
      required this.authRepo});

  // PreviewViewModel({required this.newsApi, required this.authRepo, required this.pref});
  NewsApi newsApi;
  FollowingApi followingApi;
  AuthRepo authRepo;

  final news = <NewsModel>[].obs;
  var topicModel = Get.arguments;
  var appEnvironment = Get.find<AppEnvironment>();

  // SharedPreferences pref;

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  void onRefresh() async {
    // monitor network fetch
    await handleGetNewsByTopic();
    // if failed,use refreshFailed()
    refreshController.refreshCompleted();
  }

  handleGetNewsByTopic() async {
    EasyLoading.show(status: 'fetchingData'.tr);

    var response = await newsApi.getNewsByTopicId(topicModel.value.topicId);

    if (response.statusCode != 200) {
      EasyLoading.dismiss();
      SnackbarCustom.showError(
        message: response.message!,
        altMessage: 'altMessage'.tr,
      );
    } else {
      List<NewsModel> newsList = response.resultObj!.obs;
      //clear all news before get data from API to avoid duplication
      news.clear();
      news.addAll(newsList);
      EasyLoading.dismiss();
    }
  }

  handleFollowing() async {
    var userId = await authRepo.getUserId();
    if (userId == null || userId == "") {
      Get.toNamed(Routes.LOGIN);
    }
  }

  @override
  void onInit() {
    super.onInit();
    handleGetNewsByTopic();
  }
}
