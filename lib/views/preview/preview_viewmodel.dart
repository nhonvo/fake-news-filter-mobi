import 'package:fake_news/core/api/following_api.dart';
import 'package:fake_news/core/api/news_api.dart';
import 'package:fake_news/core/base/base_view_model.dart';
import 'package:fake_news/models/news/news_model.dart';
import 'package:fake_news/providers/local_storage_repo.dart';
import 'package:fake_news/resources/utils/app_config.dart';
import 'package:fake_news/resources/utils/app_routes.dart';
import 'package:fake_news/resources/widgets/snackbar_custom.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class PreviewViewModel extends BaseViewModel {
  PreviewViewModel({required this.newsApi, required this.followingApi, required this.localRepo});

  NewsApi newsApi;
  FollowingApi followingApi;
  LocalStorageRepo localRepo;

  final news = <NewsModel>[].obs;
  var topicModel = Get.arguments;
  var appEnvironment = Get.find<AppEnvironment>();

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

  firstLoad() async {
    isFirstLoadRunning.value = true;

    var res = await newsApi.getNewsByTopicId(topicModel.value.topicId, page, pageSize);

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
        var res = await newsApi.getNewsByTopicId(topicModel.value.topicId, page, pageSize);

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

  void onRefresh() async {
    // monitor network fetch
    await firstLoad();
    // if failed,use refreshFailed()
    refreshController.refreshCompleted();
  }

  handleFollowing() async {
    var userId = await localRepo.getUserId();
    if (userId == null || userId == "") {
      Get.toNamed(Routes.LOGIN);
    }
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
