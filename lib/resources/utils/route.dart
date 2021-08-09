import 'package:fake_news/views/get_started/started_screen.dart';
import 'package:fake_news/views/home/home_screen.dart';
import 'package:fake_news/views/introduction/intro_screen.dart';
import 'package:fake_news/views/login/login_screen.dart';
import 'package:fake_news/views/preview/preview_screen.dart';
import 'package:fake_news/views/route_screen.dart';
import 'package:fake_news/views/widget_resoures.dart';
import 'package:get/get.dart';

List<GetPage> pageroute = [
  GetPage(
      name: '/test',
      page: () => const RouteScreen(),
      transition: Transition.fadeIn),
  GetPage(name: '/widgets', page: () => const WidgetResource()),
  GetPage(name: '/login', page: () => const LoginScreen()),
  GetPage(name: '/introduction', page: () => const IntroductionScreen()),
  GetPage(name: '/getstarted', page: () => const GetStartedScreen()),
  GetPage(name: '/preview', page: () => const PreviewScreen()),
  GetPage(name: '/home', page: () => const HomeScreen()),
];
