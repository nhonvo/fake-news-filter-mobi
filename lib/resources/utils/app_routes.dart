import 'package:fake_news/views/home/home_screen.dart';
import 'package:fake_news/views/introduction/intro_binding.dart';
import 'package:fake_news/views/introduction/intro_screen.dart';
import 'package:fake_news/views/login/login_binding.dart';
import 'package:fake_news/views/login/login_screen.dart';
import 'package:fake_news/views/preview/preview_binding.dart';
import 'package:fake_news/views/preview/preview_screen.dart';
import 'package:fake_news/views/splash/splash_screen.dart';
import 'package:get/get.dart';

class AppRoutes {
  AppRoutes._();

  static final appRoutes = [
    GetPage(name: Routes.INIT, page: () => SplashScreen()),
    GetPage(name: Routes.INTRO, page: () => IntroductionScreen(), binding: IntroBinding()),
    GetPage(name: Routes.PREVIEW, page: () => PreviewScreen(), binding: PreviewBinding()),
    GetPage(
      name: Routes.LOGIN,
      page: () => LoginScreen(),
      binding: LoginBinding(),
    ),
    GetPage(name: Routes.HOME, page: () => HomeScreen()),
  ];
}

class Routes {
  static const String INIT = "/splash";
  static const String INTRO = "/intro";
  static const String HOME = "/home";
  static const String LOGIN = "/login";
  static const String PREVIEW = "/preview";
}
