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
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FactNewsViewModel extends BaseViewModel {
  FactNewsViewModel(
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

  final news = <NewsModel?>[].obs;
  var index = 0.obs;

  var filter = 'real'.obs;

  get languageContent => _getLanguageContent;

  int page = 1;
  final int pageSize = 2;

  // There is next page or not
  var hasNextPage = true.obs;

  // Used to display loading indicators when _firstLoad function is running
  var isFirstLoadRunning = false.obs;

  // Used to display loading indicators when _loadMore function is running
  var isLoadMoreRunning = false.obs;

  RefreshController refreshController = RefreshController(initialRefresh: false);
  ScrollController scrollController = ScrollController();

  // void onRefresh() async {
  //   await handleGetFactNews(this.index.value == 0 ? 'real' : 'fake');
  //   refreshController.refreshCompleted();
  // }
  firstLoad() async {
    isFirstLoadRunning.value = true;

    var res = await newsApi.getNews(filter.value, languageContent, page, pageSize);

    if (res.statusCode == 200) {
      news.clear();
      news.addAll(res.resultObj!);
    } else {
      EasyLoading.dismiss();
      SnackbarCustom.showError(
        message: res.message!,
        altMessage: 'altMessage'.tr,
      );
    }

    isFirstLoadRunning.value = false;
  }

  resetPaging() {
    page = 1;
    hasNextPage.value = true;
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
        var res = await newsApi.getNews(filter.value, languageContent, page, pageSize);
        if (res.statusCode == 200 && res.resultObj!.length > 0) {
          news.addAll(res.resultObj!);
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

  String get _getLanguageContent {
    var languageContent = pref.getString(AppConstant.sharePrefKeys.languageContent);
    if (languageContent == null) {
      languageContent = 'en';
    }
    return languageContent;
  }

  @override
  void onInit() async {
    super.onInit();
    await firstLoad();
    scrollController = ScrollController()..addListener(_loadMore);
  }

  @override
  void onClosed() {
    super.onClose();
    scrollController.removeListener(_loadMore);
  }
}
