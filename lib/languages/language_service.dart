import 'package:fake_news/resources/utils/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rxdart/rxdart.dart';

class LanguageService extends GetxService {
  var language = "".obs;
  SharedPreferences sharedPreferences;

  LanguageService({
    required this.sharedPreferences,
  });
  String get currentLanguage => language.value;

  Future<LanguageService> init() async {
    await initLocalLanguage();
    return this;
  }

  /// save locale if don't have
  Future<void> initLocalLanguage() async {
    String? currentLanguageStore =
        sharedPreferences.getString(AppConstant.sharePrefKeys.language);

    if ((currentLanguageStore == '') || (currentLanguageStore == null)) {
      await setDefaultLocale(LocaleKey.EN);
    } else {
      language.value = currentLanguageStore;
    }
  }

  setDefaultLocale(String value) async {
    await sharedPreferences.setString(
        AppConstant.sharePrefKeys.language, value);
    language.value = value;
  }

  Future<void> updateLanguage(String value) async {
    Stream.fromFuture(sharedPreferences.setString(
            AppConstant.sharePrefKeys.language, value))
        .debounceTime(Duration(seconds: 2));
    language.value = value;
    Get.updateLocale(Locale(value));
  }
}
