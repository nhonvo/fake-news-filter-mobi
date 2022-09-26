import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:fake_news/core/api/following_api.dart';
import 'package:fake_news/core/api/update_api.dart';
import 'package:fake_news/core/base/base_view_model.dart';
import 'package:fake_news/models/update_model.dart';
import 'package:fake_news/providers/local_storage_repo.dart';
import 'package:fake_news/resources/utils/app_routes.dart';
import 'package:fake_news/resources/utils/style.dart';
import 'package:fake_news/resources/widgets/snackbar_custom.dart';
import 'package:get/get.dart';
import 'dart:io' show Platform, exit;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/api/language_api.dart';
import '../../models/language_model.dart';
import '../../resources/widgets/dialog_update.dart';

class SplashViewModel extends BaseViewModel {
  SplashViewModel(
      {required this.localRepo, required this.followingApi, required this.languageApi, required this.updateApi});

  LanguageApi languageApi;
  LocalStorageRepo localRepo;
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
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('version', packageInfo.version);
    packageName = packageInfo.packageName.obs;
    String currentVersionCode = packageInfo.version;

    var checkUpdate = await updateApi.checkUpdate(currentVersionCode, platform);

    if (checkUpdate.statusCode == 500) {
      return AwesomeDialog(
        context: Get.context!,
        dialogType: DialogType.ERROR,
        animType: AnimType.BOTTOMSLIDE,
        title: 'error'.tr,
        desc: 'errorServer'.tr,
        btnOkText: 'tryAgain'.tr,
        btnCancelText: 'exit'.tr,
        titleTextStyle: StylesText.content18BoldRed,
        descTextStyle: StylesText.content16BoldBlack,
        buttonsTextStyle: StylesText.content16BoldWhite,
        btnCancelOnPress: () {
          exit(0);
        },
        btnOkOnPress: () {
          handleCheckUpdate();
        },
      )..show();
    }

    List<int> statuscode = [200, 201, 202];

    if (!statuscode.contains(checkUpdate.statusCode)) {
      SnackbarCustom.showError(
        message: checkUpdate.message!,
        altMessage: 'altMessage'.tr,
      );
    } else {
      if (checkUpdate.statusCode == 201) {
        isHaveUpdate.value = true;
        UpdateDialog.showUpdate(Get.context!,
            width: Get.size.width * 0.8,
            isForce: true,
            title: "haveUpdateVersion".tr,
            updateContent: checkUpdate.resultObj!.content!, onUpdate: () {
          if (GetPlatform.isAndroid || GetPlatform.isIOS) {
            final appId = packageName.value;
            final url = Uri.parse(
              GetPlatform.isAndroid ? "market://details?id=$appId" : "https://apps.apple.com/app/id$appId",
            );
            print("URL NÈ:" + url.toString());
            launchUrl(
              url,
              mode: LaunchMode.externalApplication,
            );
          }
        });
      }
    }
  }

  handleTransition() async {
    var isFinishOnboarding = await localRepo.getIsFinishOnboarding();
    var isNotFollow = await localRepo.getIsNotFollow();
    var token = await localRepo.getAuthToken();
    var response = await languageApi.getLanguages();

    Get.create<List<LanguageModel>?>(() => response.resultObj);

    if (token != null) {
      if (isNotFollow == 'false') {
        //if user is following any topics and have token
        Get.offAllNamed(Routes.HOME);
      } else {
        //if user is not following any topics despite having token
        Get.offAllNamed(Routes.FOLLOW_TOPIC);
      }
    } else {
      //if user do not have token
      if (isFinishOnboarding == 'true')
        Get.offAllNamed(Routes.DISCOVERY);
      else
        Get.offAllNamed(Routes.ONBOARDING);
    }
  }

  @override
  void onInit() {
    super.onInit();
    handleCheckUpdate();
  }

  @override
  onReady() {
    super.onReady();
    handleTransition();
  }
}
