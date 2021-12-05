import 'package:fake_news/core/api/following_api.dart';
import 'package:fake_news/core/api/topic_api.dart';
import 'package:fake_news/core/base/base_view_model.dart';
import 'package:fake_news/models/topics/topic_model.dart';
import 'package:fake_news/providers/auth_repo.dart';
import 'package:fake_news/resources/utils/app_routes.dart';
import 'package:fake_news/resources/widgets/snackbar_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class IntroViewModel extends BaseViewModel {
  IntroViewModel({required this.topicApi, required this.followingApi, required this.authRepo});

  // IntroViewModel({required this.topicApi, required this.authRepo, required this.pref});
  TopicApi topicApi;
  FollowingApi followingApi;

  final topics = <TopicModel>[].obs;
  var topicIds = <int>[].obs;
  AuthRepo authRepo;
  // SharedPreferences pref;

  RefreshController refreshController = RefreshController(initialRefresh: false);

  void onRefresh() async {
    // monitor network fetch
    await handleGetTopic();
    // if failed,use refreshFailed()
    refreshController.refreshCompleted();
  }

  handleGetTopic() async {
    EasyLoading.show(status: 'fetchingData'.tr);

    var response = await topicApi.getTopic('en');

    if (response.isSuccessed == false) {
      EasyLoading.dismiss();
      snackBar(
        'error'.tr,
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
      List<TopicModel> topicList = response.resultObj!.obs;
      //clear all topics before get data from API to avoid duplication
      topics.clear();
      topicList.forEach((topic) {
        if (topic.noNews != 0) {
          topics.add(topic);
        }
      });
      EasyLoading.dismiss();
    }
  }

  //StartedScreen
  handlerGetListIdTopic(int id) {
    if (topicIds.contains(id)) {
      topicIds.remove(id);
    } else {
      topicIds.add(id);
    }
  }

  handleCreateFollow() async {
    EasyLoading.show(status: 'fetchingData'.tr);
    var userId = await authRepo.getUserId();

    var response = await followingApi.createFollow(topicIds, userId.toString());
    if (response.isSuccessed == false) {
      EasyLoading.dismiss();
      snackBar(
        'error'.tr,
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
      EasyLoading.dismiss();

      //set this user has followed any topics
      await authRepo.saveIsNotFollow(false);
      Get.offAllNamed(Routes.HOME);
    }
  }
}
