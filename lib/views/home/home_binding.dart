import 'package:fake_news/core/api/auth_api.dart';
import 'package:fake_news/core/api/news_api.dart';
import 'package:fake_news/core/api/vote_api.dart';
import 'package:fake_news/providers/auth_repo.dart';
import 'package:fake_news/views/breaking/breaking_viewmodel.dart';
import 'package:fake_news/views/profile_setting/profile_viewmodel.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeBinding extends Bindings {
  AuthApi authApi = Get.find();
  AuthRepo authRepo = Get.find();
  NewsApi newsApi = Get.find();
  VoteApi voteApi = Get.find();
  SharedPreferences pref = Get.find();

  @override
  void dependencies() {
    Get.put<BreakingViewModel>(BreakingViewModel(newsApi: newsApi, voteApi: voteApi, authRepo: authRepo));

    Get.put<ProfileViewModel>(ProfileViewModel(authApi: authApi, authRepo: authRepo, pref: pref));
  }
}
