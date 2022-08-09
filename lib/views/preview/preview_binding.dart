import 'package:fake_news/core/api/following_api.dart';
import 'package:fake_news/core/api/news_api.dart';
import 'package:fake_news/providers/local_storage_repo.dart';
import 'package:fake_news/views/preview/preview_viewmodel.dart';
import 'package:get/instance_manager.dart';

class PreviewBinding extends Bindings {
  NewsApi newsApi = Get.find();
  FollowingApi followingApi = Get.find();
  LocalStorageRepo localRepo = Get.find();
  // SharedPreferences pref = Get.find();

  @override
  void dependencies() {
    Get.put<PreviewViewModel>(PreviewViewModel(
        newsApi: newsApi, followingApi: followingApi, localRepo: localRepo));
  }
}
