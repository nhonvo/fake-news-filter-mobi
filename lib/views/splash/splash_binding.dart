import 'package:fake_news/core/api/following_api.dart';
import 'package:fake_news/core/api/update_api.dart';
import 'package:fake_news/providers/auth_repo.dart';
import 'package:fake_news/views/splash/splash_viewmodel.dart';
import 'package:get/instance_manager.dart';

import '../../core/api/language_api.dart';

class SplashBinding extends Bindings {
  AuthRepo authRepo = Get.find();
  UpdateApi updateApi = Get.find();
  FollowingApi followingApi = Get.find();
  LanguageApi languageApi = Get.find();

  @override
  void dependencies() {
    Get.put<SplashViewModel>(SplashViewModel(
        authRepo: authRepo,
        followingApi: followingApi,
        updateApi: updateApi,
        languageApi: languageApi));
  }
}
