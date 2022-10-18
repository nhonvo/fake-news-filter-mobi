import 'package:fake_news/core/api/comment_api.dart';
import 'package:fake_news/core/api/following_api.dart';
import 'package:fake_news/core/api/language_api.dart';
import 'package:fake_news/core/api/update_api.dart';
import 'package:fake_news/providers/local_storage_repo.dart';
import 'package:fake_news/views/splash/splash_viewmodel.dart';
import 'package:fake_news/views/view_news/viewnews_viewmodel.dart';
import 'package:get/instance_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashBinding extends Bindings {
  LocalStorageRepo localRepo = Get.find();
  UpdateApi updateApi = Get.find();
  FollowingApi followingApi = Get.find();
  LanguageApi languageApi = Get.find();
  SharedPreferences pref = Get.find();
  CommentApi commentApi = Get.find();

  @override
  void dependencies() {
    Get.put<SplashViewModel>(SplashViewModel(
        localRepo: localRepo, followingApi: followingApi, updateApi: updateApi, languageApi: languageApi));

    Get.create<ViewNewsViewModel>(() => ViewNewsViewModel(localRepo: localRepo, prefs: pref, commentApi: commentApi));
  }
}
