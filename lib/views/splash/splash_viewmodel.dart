import 'package:fake_news/core/api/following_api.dart';
import 'package:fake_news/core/api/language_api.dart';
import 'package:fake_news/core/base/base_view_model.dart';
import 'package:fake_news/models/language.dart';
import 'package:fake_news/providers/auth_repo.dart';
import 'package:fake_news/resources/utils/app_routes.dart';
import 'package:get/get.dart';

class SplashViewModel extends BaseViewModel {
  SplashViewModel({required this.authRepo, required this.languageApi, required this.followingApi});

  AuthRepo authRepo;
  LanguageApi languageApi;
  FollowingApi followingApi;

  handleTransition() async {
    var userId = await authRepo.getUserId();
    var isNotFollow = await authRepo.getIsNotFollow();
    var token = await authRepo.getAuthToken();

    var response = await languageApi.getLanguages();
    Get.put<List<LanguageModel>?>(response.resultObj);

    if (token != null) {
      if (isNotFollow == 'false') {
        //if user is following any topics and have token
        Get.offAllNamed(Routes.HOME);
      } else {
        //if user is not following any topics despite having token
        Get.offAllNamed(Routes.LAUNCH);
      }
    } else {
      //if user do not have token
      Get.offAllNamed(Routes.INTRO);
    }
  }
}
