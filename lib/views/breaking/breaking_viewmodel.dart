import 'dart:async';
import 'package:fake_news/core/api/extra_api.dart';
import 'package:fake_news/core/api/news_api.dart';
import 'package:fake_news/core/api/vote_api.dart';
import 'package:fake_news/core/base/base_view_model.dart';
import 'package:fake_news/models/news/news_model.dart';
import 'package:fake_news/providers/local_storage_repo.dart';
import 'package:fake_news/resources/utils/app_constant.dart';
import 'package:fake_news/resources/widgets/snackbar_custom.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BreakingViewModel extends BaseViewModel {
  BreakingViewModel(
      {required this.newsApi,
      required this.voteApi,
      required this.extraApi,
      required this.pref,
      required this.localRepo});

  NewsApi newsApi;
  VoteApi voteApi;
  LocalStorageRepo localRepo;
  ExtraApi extraApi;
  SharedPreferences pref;

  final newsLoadMore = <NewsModel?>[].obs;
  var searchingNews = <NewsModel?>[].obs;
  // var isLoaded = false.obs;

  get languageContent => _getLanguageContent;
  get userId => _getUserId;
  //hide progress searching
  var isSearching = false.obs;

  int page = 1;
  final int pageSize = 5;

  // There is next page or not
  var hasNextPage = true.obs;

  // Used to display loading indicators when _firstLoad function is running
  var isFirstLoadRunning = false.obs;

  // Used to display loading indicators when _loadMore function is running
  var isLoadMoreRunning = false.obs;

  RefreshController refreshController = RefreshController(initialRefresh: false);
  ScrollController scrollController = ScrollController();
  FloatingSearchBarController floatingSearchBarController = FloatingSearchBarController();

  void onRefresh() async {
    // monitor network fetch
    // await _firstLoad();
    // if failed,use refreshFailed()
    refreshController.refreshCompleted();
  }

  // handleGetNewsByFollowedTopic() async {
  //   // EasyLoading.show(status: 'fetchingData'.tr);

  //   // var userId = await localRepo.getUserId();
  //   await OneSignal.shared.setExternalUserId(userId!).then((results) {
  //     print(results.toString());
  //   }).catchError((error) {
  //     print(error.toString());
  //   });

  //   var response = await newsApi.getNewsByFollowedTopic(userId.toString(), page, pageSize);

  //   if (response.statusCode != 200) {
  //     EasyLoading.dismiss();
  //     SnackbarCustom.showError(
  //       message: response.message!,
  //       altMessage: 'altMessage'.tr,
  //     );
  //   }
  // }

  handleGetCountView(int newsId) async {
    try {
      await newsApi.getViewCount(newsId);
    } catch (e) {
      print(e);
    }
  }

  _firstLoad() async {
    isFirstLoadRunning.value = true;

    // var userId = await localRepo.getUserId();

    await OneSignal.shared.setExternalUserId(userId!).then((results) {
      print(results.toString());
    }).catchError((error) {
      print(error.toString());
    });

    var res = await newsApi.getNewsByFollowedTopic(userId.toString(), page, pageSize);

    if (res.statusCode == 200) {
      newsLoadMore.addAll(res.resultObj!);
    } else {
      EasyLoading.dismiss();
      SnackbarCustom.showError(
        message: res.message!,
        altMessage: 'altMessage'.tr,
      );
    }

    isFirstLoadRunning.value = false;
  }

  _loadMore() async {
    if (hasNextPage.value == true &&
        isFirstLoadRunning.value == false &&
        isLoadMoreRunning.value == false &&
        scrollController.position.extentAfter < 300) {
      // Display a progress indicator at the bottom
      isLoadMoreRunning.value = true;

      page += 1; // Increase page by 1
      try {
        var res = await newsApi.getNewsByFollowedTopic(userId, page, pageSize);
        if (res.statusCode == 200 && res.resultObj!.length > 0) {
          newsLoadMore.addAll(res.resultObj!);
        } else {
          // This means there is no more data
          // and therefore, we will not send another GET request
          hasNextPage.value = false;
          SnackbarCustom.showInfo(message: 'fetchingLoadMore'.tr);
        }
      } catch (err) {
        print('Something went wrong!');
      }
      isLoadMoreRunning.value = false;
    }
  }

  //💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥Rating button💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥
  Future<void> vote(bool isReal, String newsId) async {
    // var userId = await localRepo.getUserId();
    var response = await voteApi.createVote(userId, newsId, isReal);

    newsLoadMore.removeWhere((e) => e!.newsId == int.parse(newsId));

    if (response.statusCode != 200) {
      EasyLoading.dismiss();
      SnackbarCustom.showError(
        message: response.message!,
        altMessage: 'altMessage'.tr,
      );
    }
  }

//💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥Searching💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥
  void search(String keyword) async {
    //show progress searching
    isSearching.value = true;

    if (keyword.trim().isNotEmpty) {
      var response = await extraApi.search(keyword, languageContent ?? 'en');

      searchingNews.clear();
      searchingNews.addAll(response.resultObj?.news?.toList() ?? []);
    }

    //hide progress searching
    isSearching.value = false;
  }

  String get _getLanguageContent {
    var languageContent = pref.getString(AppConstant.sharePrefKeys.languageContent);
    if (languageContent == null) {
      languageContent = 'en';
    }
    return languageContent;
  }

  String get _getUserId {
    var userId = pref.getString(AppConstant.sharePrefKeys.userId);
    if (userId == null) {
      throw Exception('User id is null');
    }
    return userId;
  }

  @override
  void onInit() async {
    super.onInit();
    await _firstLoad();
    // await handleGetNewsByFollowedTopic();
    scrollController = ScrollController()..addListener(_loadMore);
    // isLoaded.value = true;
  }

  @override
  void onClose() {
    scrollController.removeListener(_loadMore);
    super.onClose();
  }
}
