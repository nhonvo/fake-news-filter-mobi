import 'package:fake_news/resources/utils/app_config.dart';
import 'package:fake_news/services/app_service/app_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'languages/language_service.dart';
import 'languages/localization.dart';
import 'resources/utils/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Get.put<AppEnvironment>(AppEnvironment.dev());

  await AppServices.initServices();

  runApp(const MyApp());
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
      initialRoute: Routes.INTRO,
    );
  }
}
