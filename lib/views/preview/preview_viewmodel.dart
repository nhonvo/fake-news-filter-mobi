import 'package:fake_news/core/api/news_api.dart';
import 'package:fake_news/core/base/base_view_model.dart';
import 'package:fake_news/models/news/news_model.dart';
import 'package:fake_news/resources/widgets/snackbar_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PreviewViewModel extends BaseViewModel {
  PreviewViewModel({required this.newsApi});

  // PreviewViewModel({required this.newsApi, required this.authRepo, required this.pref});
  NewsApi newsApi;
  final news = <NewsModel>[].obs;
  var topicModel = Get.arguments;

  // AuthRepo authRepo;
  // SharedPreferences pref;

  RefreshController refreshController = RefreshController(initialRefresh: false);

  void onRefresh() async {
    // monitor network fetch
    await handleGetNewsByTopic();
    // if failed,use refreshFailed()
    refreshController.refreshCompleted();
  }

  handleGetNewsByTopic() async {
    EasyLoading.show(status: 'fetchingData'.tr);

    var response = await newsApi.getNewsById(topicModel.value.topicId);

    if (response.isSuccessed == false) {
      EasyLoading.dismiss();
      snackBar(
        'Error',
        response.messages!,
        'altMessage'.tr,
        Icon(
          Icons.error,
          color: Colors.white,
        ),
        Colors.red,
        Colors.white,
        SnackPosition.BOTTOM,
      );
    } else {
      List<NewsModel> newsList = response.resultObj!.obs;
      //clear all news before get data from API to avoid duplication
      news.clear();
      newsList.forEach((topic) {
        news.add(topic);
      });
      EasyLoading.dismiss();
    }
  }

  @override
  void onInit() {
    super.onInit();
    handleGetNewsByTopic();
  }
}
