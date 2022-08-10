import 'package:fake_news/core/api/following_api.dart';
import 'package:fake_news/core/api/news_api.dart';
import 'package:fake_news/providers/local_storage_repo.dart';
import 'package:fake_news/views/preview/preview_viewmodel.dart';
import 'package:get/instance_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/api/extra_api.dart';
import '../../core/api/vote_api.dart';
import '../breaking/breaking_viewmodel.dart';

class PreviewBinding extends Bindings {
  NewsApi newsApi = Get.find();
  FollowingApi followingApi = Get.find();
  LocalStorageRepo localRepo = Get.find();
  SharedPreferences pref = Get.find();
  VoteApi voteApi = Get.find();
  ExtraApi extraApi = Get.find();

  @override
  void dependencies() {
    Get.put<PreviewViewModel>(PreviewViewModel(newsApi: newsApi, followingApi: followingApi, localRepo: localRepo));
    Get.put<BreakingViewModel>(
        BreakingViewModel(newsApi: newsApi, voteApi: voteApi, extraApi: extraApi, pref: pref, localRepo: localRepo));
  }
}
