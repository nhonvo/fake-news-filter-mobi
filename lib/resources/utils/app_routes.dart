import 'package:fake_news/views/comming_soon_screen.dart';
import 'package:fake_news/views/follow_topic/follow_topic.dart';
import 'package:fake_news/views/home/home_binding.dart';
import 'package:fake_news/views/home/home_screen.dart';
import 'package:fake_news/views/discovery/discovery_binding.dart';
import 'package:fake_news/views/discovery/discovery_screen.dart';
import 'package:fake_news/views/login/login_binding.dart';
import 'package:fake_news/views/login/login_screen.dart';
import 'package:fake_news/views/login/signup_screen.dart';
import 'package:fake_news/views/onboarding/onboarding_binding.dart';
import 'package:fake_news/views/onboarding/onboarding_screen.dart';
import 'package:fake_news/views/preview/preview_binding.dart';
import 'package:fake_news/views/preview/preview_screen.dart';
import 'package:fake_news/views/splash/splash_binding.dart';
import 'package:fake_news/views/splash/splash_screen.dart';
import 'package:get/get.dart';

class AppRoutes {
  AppRoutes._();

  static final appRoutes = [
    GetPage(
        name: Routes.INIT,
        page: () => SplashScreen(),
        binding: SplashBinding()),
    GetPage(
        name: Routes.FOLLOW_TOPIC,
        page: () => FollowTopicScreen(),
        binding: DiscoveryBinding()),
    GetPage(
        name: Routes.DISCOVERY,
        page: () => DiscoveryScreen(),
        binding: DiscoveryBinding()),
    GetPage(
        name: Routes.PREVIEW,
        page: () => PreviewScreen(),
        binding: PreviewBinding()),
    GetPage(
      name: Routes.LOGIN,
      page: () => LoginScreen(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: Routes.SIGNUP,
      page: () => SignupScreen(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: Routes.HOME,
      page: () => HomeScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.CONTRIBUTE,
      page: () => ComingSoonScreen(),
    ),
    GetPage(
      name: Routes.ONBOARDING,
      page: () => OnBoardingScreen(),
      binding: OnboardingBinding(),
    ),
  ];
}

class Routes {
  static const String INIT = "/splash";
  static const String DISCOVERY = "/discovery";
  static const String FOLLOW_TOPIC = "/followTopic";
  static const String HOME = "/home";
  static const String LOGIN = "/login";
  static const String SIGNUP = '/signup';
  static const String PREVIEW = "/preview";
  static const String CONTRIBUTE = "/contribute";
  static const String ONBOARDING = "/onboarding";
}
