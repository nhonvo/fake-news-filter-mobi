import 'package:fake_news/core/api/auth_api.dart';
import 'package:fake_news/core/api/news_community_api.dart';
import 'package:fake_news/providers/local_storage_repo.dart';
import 'package:fake_news/resources/utils/app_config.dart';
import 'package:fake_news/services/language_service/language_service.dart';
import 'package:get/instance_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'contribute_viewmodel.dart';

class ContributeBinding extends Bindings {
  NewsCommunityApi newsCommunityApi = Get.find();
  SharedPreferences pref = Get.find();
  AuthApi authApi = Get.find();
  LocalStorageRepo localRepo = Get.find();
  AppEnvironment appEnvironment = Get.find();
  LanguageService languageService = Get.find();

  @override
  void dependencies() {
    Get.put<ContributeViewModel>(
      ContributeViewModel(
        newsCommunityApi: newsCommunityApi,
        prefs: pref,
        appEnvironment: appEnvironment,
        languageService: languageService,
        authApi: authApi,
        localRepo: localRepo,
      ),
    );
  }
}
