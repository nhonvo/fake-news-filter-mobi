import 'package:fake_news/core/api/news_api.dart';
import 'package:fake_news/core/base/base_view_model.dart';
import 'package:fake_news/models/news/news_model.dart';
import 'package:fake_news/providers/auth_repo.dart';
import 'package:fake_news/resources/widgets/snackbar_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class BreakingViewModel extends BaseViewModel {
  BreakingViewModel({required this.newsApi, required this.authRepo});

  NewsApi newsApi;
  AuthRepo authRepo;

  final news = <NewsModel>[].obs;

  handleGetNewsByFollowedTopic() async {
    EasyLoading.show(status: 'fetchingData'.tr);

    var userId = await authRepo.getUserId();

    var response = await newsApi.getNewsByFollowedTopic(userId.toString());

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
      List<NewsModel> newsList = response.resultObj!.obs;
      //clear all news before get data from API to avoid duplication
      news.clear();
      newsList.forEach((news) {
        this.news.add(news);
      });
      EasyLoading.dismiss();
    }
  }
}
