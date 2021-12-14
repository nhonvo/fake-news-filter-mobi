import 'dart:io';

import 'package:fake_news/resources/utils/app_config.dart';
import 'package:fake_news/resources/utils/style.dart';
import 'package:fake_news/services/app_service/app_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'languages/language_service.dart';
import 'languages/localization.dart';
import 'resources/utils/app_routes.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  HttpOverrides.global = new MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();

  Get.put<AppEnvironment>(AppEnvironment.dev());

  await AppServices.initServices();

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
      initialRoute: Routes.INIT,
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
