import 'dart:io';

import 'package:fake_news/resources/utils/app_config.dart';
import 'package:fake_news/resources/utils/style.dart';
import 'package:fake_news/services/app_service/app_services.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'services/language_service/language_service.dart';
import 'services/language_service/localization.dart';
import 'resources/utils/app_routes.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  HttpOverrides.global = new MyHttpOverrides();

  WidgetsFlutterBinding.ensureInitialized();

  GestureBinding.instance?.resamplingEnabled = true; //Custom Gesture ListView

  Get.put<AppEnvironment>(AppEnvironment.live());

  await AppServices.initServices();

  initOneSignal();

  runApp(const MyApp());

  configLoading();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final language = Get.find<LanguageService>();
    return GetMaterialApp(
      builder: EasyLoading.init(),
      debugShowCheckedModeBanner: false,
      locale: Locale(language.currentLanguage),
      translations: Localization(),
      getPages: AppRoutes.appRoutes,
      initialRoute: Routes.ONBOARDING,
      defaultTransition: Transition.rightToLeftWithFade,
    );
  }
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = MyColors.blue
    ..backgroundColor = MyColors.blueEgg
    ..indicatorColor = MyColors.blue
    ..textColor = MyColors.blue
    ..userInteractions = true
    ..dismissOnTap = false;
}

void initOneSignal() {
  //Remove this method to stop OneSignal Debugging
  OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

  OneSignal.shared.setAppId("fabd12c6-0ad1-4e5a-bdad-78fabebae2a7");
}
