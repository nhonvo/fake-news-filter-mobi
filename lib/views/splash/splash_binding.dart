import 'package:fake_news/core/api/following_api.dart';
import 'package:fake_news/core/api/language_api.dart';
import 'package:fake_news/providers/auth_repo.dart';
import 'package:fake_news/views/splash/splash_viewmodel.dart';
import 'package:get/instance_manager.dart';

class SplashBinding extends Bindings {
  AuthRepo authRepo = Get.find();
  LanguageApi languageApi = Get.find();
  FollowingApi followingApi = Get.find();

  @override
  void dependencies() {
    Get.put<SplashViewModel>(SplashViewModel(authRepo: authRepo, languageApi: languageApi, followingApi: followingApi));
  }
}
