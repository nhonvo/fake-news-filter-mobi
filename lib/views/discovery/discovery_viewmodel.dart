import 'package:fake_news/core/api/following_api.dart';
import 'package:fake_news/core/api/topic_api.dart';
import 'package:fake_news/core/base/base_view_model.dart';
import 'package:fake_news/services/language_service/language_service.dart';
import 'package:fake_news/models/language_model.dart';
import 'package:fake_news/models/topics/topic_model.dart';
import 'package:fake_news/providers/local_storage_repo.dart';
import 'package:fake_news/resources/utils/app_config.dart';
import 'package:fake_news/resources/utils/app_constant.dart';
import 'package:fake_news/resources/utils/app_routes.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../resources/widgets/snackbar_custom.dart';

class DiscoveryViewModel extends BaseViewModel {
  DiscoveryViewModel(
      {required this.topicApi,
      required this.followingApi,
      required this.languageService,
      required this.localRepo,
      required this.prefs,
      required this.appEnvironment});

  TopicApi topicApi;
  FollowingApi followingApi;
  LocalStorageRepo localRepo;
  SharedPreferences prefs;
  AppEnvironment appEnvironment;

  final topics = <TopicModel>[].obs;
  var topicIdListHasFollowed = <int>[].obs;
//used to choose the language in choose language screen
  var languagesList = Get.find<List<LanguageModel>?>();
  LanguageService languageService;

  var selectedValue = 0.obs;
  var getLanguageContent = "".obs, tempLanguageContent = "".obs;
////////////////////////////////////////////////////////////

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  void onRefresh() async {
    // monitor network fetch
    await handleGetTopic();
    // if failed,use refreshFailed()
    refreshController.refreshCompleted();
  }

  handleGetTopic() async {
    EasyLoading.show(status: 'fetchingData'.tr);

    var languageContent =
        prefs.getString(AppConstant.sharePrefKeys.languageContent);

    var response = await topicApi.getTopic(languageContent ?? 'en');

    var userId = await localRepo.getUserId();

    //get the topic ids of the user has followed topics
    if (userId?.isNotEmpty ?? false) {
      var result = await followingApi.getFollowedTopic(userId.toString());
      topicIdListHasFollowed.addAll(result.resultObj?.map((e) => e) ?? []);
    }

    if (response.statusCode != 200) {
      EasyLoading.dismiss();
      SnackbarCustom.showError(
        message: response.message!,
        altMessage: 'altMessage'.tr,
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

  //💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥StartedScreen💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥
  handlerGetListIdTopic(int id) async {
    if (topicIdListHasFollowed.contains(id)) {
      topicIdListHasFollowed.remove(id);
    } else {
      topicIdListHasFollowed.add(id);
    }
  }

  handleCreateFollow() async {
    EasyLoading.show(status: 'fetchingData'.tr);
    var userId = await localRepo.getUserId();

    var response = await followingApi.createFollow(
        topicIdListHasFollowed, userId.toString());
    if (response.statusCode != 200) {
      EasyLoading.dismiss();
      SnackbarCustom.showError(
        message: response.message!,
        altMessage: 'altMessage'.tr,
      );
    } else {
      EasyLoading.dismiss();

      //set this user has followed any topics
      await localRepo.saveIsNotFollow(false);
      Get.offAllNamed(Routes.HOME);
    }
  }

  //💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥ChooseLanguageScreen💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥
  handleChangeLanguage() async {
    if (languageService.currentLanguage == "en") {
      languageService.updateLanguage("vi");
    } else {
      languageService.updateLanguage("en");
    }
  }

  @override
  void onInit() {
    super.onInit();

    handleGetTopic();

    //used to choose the language in choose language screen
    getLanguageContent.value =
        prefs.getString(AppConstant.sharePrefKeys.languageContent) ?? "";
    //saving selected language content to temporary variable for compare with new language content
    tempLanguageContent.value = getLanguageContent.value;
  }
}
