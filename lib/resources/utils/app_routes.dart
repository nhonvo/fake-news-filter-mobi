import 'package:fake_news/views/introduction/intro_screen.dart';
import 'package:fake_news/views/login/login_binding.dart';
import 'package:fake_news/views/login/login_screen.dart';
import 'package:fake_news/views/preview/preview_screen.dart';
import 'package:fake_news/views/splash/splash_screen.dart';
import 'package:get/get.dart';

class AppRoutes {
  AppRoutes._();

  static final appRoutes = [
    GetPage(name: Routes.INIT, page: () => SplashScreen()),
    GetPage(name: Routes.HOME, page: () => IntroductionScreen()),
    GetPage(name: Routes.PREVIEW, page: () => PreviewScreen()),
    GetPage(
      name: Routes.LOGIN,
      page: () => LoginScreen(),
      binding: LoginBinding(),
    )
  ];
}

class Routes {
  static const String INIT = "/splash";
  static const String HOME = "/intro";
  static const String LOGIN = "/login";
  static const String PREVIEW = "/preview";
}
