import 'package:fake_news/core/api/news_api.dart';
import 'package:fake_news/views/preview/preview_viewmodel.dart';
import 'package:get/instance_manager.dart';

class PreviewBinding extends Bindings {
  NewsApi newsApi = Get.find();
  // AuthRepo authRepo = Get.find();
  // SharedPreferences pref = Get.find();

  @override
  void dependencies() {
    // Get.put<PreviewViewModel>(PreviewViewModel(newsApi: newsApi, authRepo: authRepo, pref: pref));

    Get.put<PreviewViewModel>(PreviewViewModel(newsApi: newsApi));
  }
}
