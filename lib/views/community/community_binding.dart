import 'package:fake_news/core/api/following_api.dart';
import 'package:fake_news/core/api/news_community_api.dart';
import 'package:fake_news/core/api/topic_api.dart';
import 'package:fake_news/providers/auth_repo.dart';
import 'package:fake_news/resources/utils/app_config.dart';
import 'package:fake_news/services/language_service/language_service.dart';
import 'package:fake_news/views/community/community_viewmodel.dart';
import 'package:get/instance_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CommunityBinding extends Bindings {
  TopicApi topicApi = Get.find();
  FollowingApi followingApi = Get.find();
  NewsCommunityApi newsCommunityApi = Get.find();
  AuthRepo authRepo = Get.find();
  SharedPreferences pref = Get.find();
  AppEnvironment appEnvironment = Get.find();
  LanguageService languageService = Get.find();

  @override
  void dependencies() {
    Get.put<CommunityViewModel>(CommunityViewModel(
        topicApi: topicApi,
        followingApi: followingApi,
        newsCommunityApi: newsCommunityApi,
        languageService: languageService,
        authRepo: authRepo,
        prefs: pref,
        appEnvironment: appEnvironment));
  }
}
