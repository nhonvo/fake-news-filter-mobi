import 'package:fake_news/core/api/extra_api.dart';
import 'package:fake_news/core/api/news_api.dart';
import 'package:fake_news/core/api/vote_api.dart';
import 'package:fake_news/core/base/base_view_model.dart';
import 'package:fake_news/models/news/news_model.dart';
import 'package:fake_news/providers/auth_repo.dart';
import 'package:fake_news/resources/utils/app_constant.dart';
import 'package:fake_news/resources/widgets/snackbar_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FactNewsViewModel extends BaseViewModel {
  FactNewsViewModel(
      {required this.newsApi,
      required this.voteApi,
      required this.extraApi,
      required this.pref,
      required this.authRepo});

  NewsApi newsApi;
  VoteApi voteApi;
  AuthRepo authRepo;
  ExtraApi extraApi;
  SharedPreferences pref;

  final news = <NewsModel?>[].obs;
  var searchingNews = <NewsModel?>[].obs;
  var isLoaded = false.obs;
  var index = 0.obs;

  RefreshController refreshController = RefreshController(initialRefresh: false);

  // void onRefresh() async {
  //   await handleGetFactNews(this.index.value == 0 ? 'real' : 'fake');
  //   refreshController.refreshCompleted();
  // }

  handleGetFactNews(String? filter) async {
    EasyLoading.show(status: 'fetchingData'.tr);

    var languageContent = pref.getString(AppConstant.sharePrefKeys.languageContent);

    var response = await newsApi.getNews(filter, languageContent);

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
      news.addAll(newsList);
      isLoaded.value = true;
      EasyLoading.dismiss();
    }
  }

  @override
  void onInit() async {
    super.onInit();
    await handleGetFactNews('real');
    isLoaded.value = true;
  }
}
