import 'package:fake_news/core/api/following_api.dart';
import 'package:fake_news/core/api/topic_api.dart';
import 'package:fake_news/providers/auth_repo.dart';
import 'package:fake_news/views/discovery/discovery_viewmodel.dart';
import 'package:get/instance_manager.dart';

class DiscoveryBinding extends Bindings {
  TopicApi topicApi = Get.find();
  FollowingApi followingApi = Get.find();
  AuthRepo authRepo = Get.find();
  // SharedPreferences pref = Get.find();

  @override
  void dependencies() {
    // Get.put<IntroViewModel>(IntroViewModel(topicApi: topicApi, authRepo: authRepo, pref: pref));

    Get.put<DiscoveryViewModel>(DiscoveryViewModel(topicApi: topicApi, followingApi: followingApi, authRepo: authRepo));
  }
}