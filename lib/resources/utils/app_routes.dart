import 'package:fake_news/views/login/login_binding.dart';
import 'package:fake_news/views/login/login_screen.dart';
import 'package:fake_news/views/splash/splash_screen.dart';
import 'package:get/get.dart';

class AppRoutes {
  AppRoutes._();

  static final appRoutes = [
    GetPage(name: Routes.INIT, page: () => SplashScreen()),
    GetPage(
      name: Routes.LOGIN,
      page: () => LoginScreen(),
      binding: LoginBinding(),
    )
  ];
}

class Routes {
  static const String INIT = "/splash";
  static const String HOME = "/";
  static const String LOGIN = "/login";
}
