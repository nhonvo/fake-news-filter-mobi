import 'package:fake_news/core/api/topic_api.dart';
import 'package:fake_news/core/base/base_view_model.dart';
import 'package:fake_news/models/topics/topic_model.dart';
import 'package:fake_news/resources/utils/app_routes.dart';
import 'package:fake_news/resources/widgets/snackbar_custom.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class IntroViewModel extends BaseViewModel {
  IntroViewModel({required this.topicApi});

  // IntroViewModel({required this.topicApi, required this.authRepo, required this.pref});
  TopicApi topicApi;
  final topics = <TopicModel>[].obs;
  // AuthRepo authRepo;
  // SharedPreferences pref;

  RefreshController refreshController = RefreshController(initialRefresh: false);

  void onRefresh() async {
    // monitor network fetch
    await handleGetTopic();
    // if failed,use refreshFailed()
    refreshController.refreshCompleted();
  }

  handleGetTopic() async {
    // ProgressHud.showLoading();

    var response = await topicApi.getTopic('en');

    if (response.isSuccessed == false) {
      // ProgressHud.hideLoading();
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
      List<TopicModel> topicList = response.resultObj!.obs;
      //clear all topics before get data from API to avoid duplication
      topics.clear();
      topicList.forEach((topic) {
        topics.add(topic);
      });
    }
  }
}
