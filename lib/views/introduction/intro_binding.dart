import 'package:fake_news/core/api/topic_api.dart';
import 'package:fake_news/providers/auth_repo.dart';
import 'package:fake_news/views/introduction/intro_viewmodel.dart';
import 'package:get/instance_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IntroBinding extends Bindings {
  TopicApi topicApi = Get.find();
  // AuthRepo authRepo = Get.find();
  // SharedPreferences pref = Get.find();

  @override
  void dependencies() {
    // Get.put<IntroViewModel>(IntroViewModel(topicApi: topicApi, authRepo: authRepo, pref: pref));

    Get.put<IntroViewModel>(IntroViewModel(topicApi: topicApi));
  }
}
