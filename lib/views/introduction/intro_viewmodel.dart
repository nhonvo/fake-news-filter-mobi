import 'package:fake_news/core/api/topic_api.dart';
import 'package:fake_news/core/base/base_view_model.dart';
import 'package:fake_news/models/topics/topic_model.dart';
import 'package:fake_news/resources/widgets/snackbar_custom.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IntroViewModel extends BaseViewModel {
  IntroViewModel({required this.topicApi});

  // IntroViewModel({required this.topicApi, required this.authRepo, required this.pref});
  TopicApi topicApi;
  final topics = <TopicModel>[].obs;
  // AuthRepo authRepo;
  // SharedPreferences pref;

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
      topicList.forEach((topic) {
        topics.add(topic);
      });
      // Get.toNamed(Routes.HOME);
    }
  }
}
