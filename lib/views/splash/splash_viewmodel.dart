import 'package:fake_news/core/api/following_api.dart';
import 'package:fake_news/core/api/update_api.dart';
import 'package:fake_news/core/base/base_view_model.dart';
import 'package:fake_news/models/update_model.dart';
import 'package:fake_news/providers/auth_repo.dart';
import 'package:fake_news/resources/utils/app_routes.dart';
import 'package:fake_news/resources/widgets/snackbar_custom.dart';
import 'package:get/get.dart';
import 'dart:io' show Platform;
import 'package:package_info_plus/package_info_plus.dart';
import '../../core/api/language_api.dart';
import '../../models/language_model.dart';

class SplashViewModel extends BaseViewModel {
  SplashViewModel(
      {required this.authRepo,
      required this.followingApi,
      required this.languageApi,
      required this.updateApi});

  LanguageApi languageApi;
  AuthRepo authRepo;
  FollowingApi followingApi;
  UpdateApi updateApi;

  var version = VersionModel().obs;

  var isHaveUpdate = false.obs;

  var packageName = ''.obs;

  handleCheckUpdate() async {
    //Lấy thông tin nền tảng (Android, iOS)
    String platform = Platform.operatingSystem;

    //Lấy thông tin phiên bản hiện tại
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    packageName = packageInfo.packageName.obs;
    String currentVersionCode = packageInfo.version;

    var checkUpdate = await updateApi.checkUpdate(currentVersionCode, platform);
    List<int> statuscode = [200, 201, 202];

    if (!statuscode.contains(checkUpdate.statusCode)) {
      SnackbarCustom.showError(
        message: checkUpdate.message!,
        altMessage: 'altMessage'.tr,
      );
    } else {
      if (checkUpdate.statusCode == 201) {
        isHaveUpdate.value = true;
        version = checkUpdate.resultObj!.obs;
      }
    }
  }

  handleTransition() async {
    var isNotFollow = await authRepo.getIsNotFollow();
    var token = await authRepo.getAuthToken();
    var response = await languageApi.getLanguages();

    Get.create<List<LanguageModel>?>(() => response.resultObj);

    if (token != "") {
      if (isNotFollow == 'false') {
        //if user is following any topics and have token
        Get.offAllNamed(Routes.HOME);
      } else {
        //if user is not following any topics despite having token
        Get.offAllNamed(Routes.FOLLOW_TOPIC);
      }
    } else {
      //if user do not have token
      Get.offAllNamed(Routes.ONBOARDING);
    }
  }

  @override
  void onInit() async {
    super.onInit();
    await handleCheckUpdate();
    if (isHaveUpdate.isFalse) {
      await handleTransition();
    }
  }
}
