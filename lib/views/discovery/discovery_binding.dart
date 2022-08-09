import 'package:fake_news/core/api/following_api.dart';
import 'package:fake_news/core/api/topic_api.dart';
import 'package:fake_news/providers/local_storage_repo.dart';
import 'package:fake_news/resources/utils/app_config.dart';
import 'package:fake_news/services/language_service/language_service.dart';
import 'package:fake_news/views/discovery/discovery_viewmodel.dart';
import 'package:get/instance_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DiscoveryBinding extends Bindings {
  TopicApi topicApi = Get.find();
  FollowingApi followingApi = Get.find();
  LocalStorageRepo localRepo = Get.find();
  SharedPreferences pref = Get.find();
  AppEnvironment appEnvironment = Get.find();
  LanguageService languageService = Get.find();

  @override
  void dependencies() {
    Get.put<DiscoveryViewModel>(DiscoveryViewModel(
        topicApi: topicApi,
        followingApi: followingApi,
        languageService: languageService,
        localRepo: localRepo,
        prefs: pref,
        appEnvironment: appEnvironment));
  }
}
