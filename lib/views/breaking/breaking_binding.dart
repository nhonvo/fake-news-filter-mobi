import 'package:fake_news/core/api/news_api.dart';
import 'package:fake_news/providers/auth_repo.dart';
import 'package:fake_news/views/breaking/breaking_viewmodel.dart';
import 'package:get/instance_manager.dart';

class BreakingBinding extends Bindings {
  NewsApi newsApi = Get.find();
  AuthRepo authRepo = Get.find();

  @override
  void dependencies() {
    Get.put<BreakingViewModel>(BreakingViewModel(newsApi: newsApi, authRepo: authRepo));
  }
}
