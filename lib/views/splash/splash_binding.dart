import 'package:fake_news/core/api/following_api.dart';
import 'package:fake_news/core/api/language_api.dart';
import 'package:fake_news/core/api/update_api.dart';
import 'package:fake_news/providers/local_storage_repo.dart';
import 'package:fake_news/views/splash/splash_viewmodel.dart';
import 'package:get/instance_manager.dart';

class SplashBinding extends Bindings {
  LocalStorageRepo localRepo = Get.find();
  UpdateApi updateApi = Get.find();
  FollowingApi followingApi = Get.find();
  LanguageApi languageApi = Get.find();

  @override
  void dependencies() {
    Get.put<SplashViewModel>(SplashViewModel(
        localRepo: localRepo,
        followingApi: followingApi,
        updateApi: updateApi,
        languageApi: languageApi));
  }
}
