import 'package:fake_news/core/api/auth_api.dart';
import 'package:fake_news/core/api/extra_api.dart';
import 'package:fake_news/core/api/following_api.dart';
import 'package:fake_news/core/api/news_api.dart';
import 'package:fake_news/core/api/topic_api.dart';
import 'package:fake_news/core/api/vote_api.dart';
import 'package:fake_news/providers/auth_repo.dart';
import 'package:fake_news/resources/utils/app_config.dart';
import 'package:fake_news/services/language_service/language_service.dart';
import 'package:fake_news/views/breaking/breaking_viewmodel.dart';
import 'package:fake_news/views/community/community_viewmodel.dart';
import 'package:fake_news/views/discovery/discovery_viewmodel.dart';
import 'package:fake_news/views/fact_news/fact_news_viewmodel.dart';
import 'package:fake_news/views/profile_setting/profile_viewmodel.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeBinding extends Bindings {
  AuthApi authApi = Get.find();
  AuthRepo authRepo = Get.find();
  NewsApi newsApi = Get.find();
  VoteApi voteApi = Get.find();
  ExtraApi extraApi = Get.find();
  TopicApi topicApi = Get.find();
  FollowingApi followingApi = Get.find();
  LanguageService languageService = Get.find();
  SharedPreferences pref = Get.find();
  AppEnvironment appEnvironment = Get.find();

  @override
  void dependencies() {
    Get.lazyPut<DiscoveryViewModel>(() => DiscoveryViewModel(
        topicApi: topicApi,
        followingApi: followingApi,
        languageService: languageService,
        authRepo: authRepo,
        prefs: pref,
        appEnvironment: appEnvironment));

    Get.put<BreakingViewModel>(
        BreakingViewModel(newsApi: newsApi, voteApi: voteApi, extraApi: extraApi, pref: pref, authRepo: authRepo));
    Get.put<FactNewsViewModel>(
        FactNewsViewModel(newsApi: newsApi, voteApi: voteApi, extraApi: extraApi, pref: pref, authRepo: authRepo));

    Get.lazyPut<CommunityViewModel>(() => CommunityViewModel(
        topicApi: topicApi,
        followingApi: followingApi,
        languageService: languageService,
        authRepo: authRepo,
        prefs: pref,
        appEnvironment: appEnvironment));
    Get.put<ProfileViewModel>(ProfileViewModel(authApi: authApi, authRepo: authRepo, pref: pref));
  }
}
