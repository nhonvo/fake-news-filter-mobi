import 'package:fake_news/views/login/login_screen.dart';
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
];
