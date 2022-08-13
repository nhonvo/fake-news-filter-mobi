// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables
import 'package:bottom_bar/bottom_bar.dart';
import 'package:fake_news/resources/utils/image.dart';
import 'package:fake_news/resources/utils/style.dart';
import 'package:fake_news/views/breaking/breaking_screen.dart';
import 'package:fake_news/views/comming_soon_screen.dart';
import 'package:fake_news/views/fact_news/fact_news_screen.dart';
import 'package:fake_news/views/profile_setting/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const List<Widget> _widgetOptions = <Widget>[
    BreakingScreen(),
    FactNewsScreen(),
    ComingSoonScreen(),
    ProfileScreen(),
  ];

  var cIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              Images.logo,
              width: Get.size.width * 0.13,
            ),
            const SizedBox(width: 10),
            Text('appname'.tr, style: StylesText.content16BoldWhite)
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {},
          )
        ],
      ),
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomBar(
        textStyle: StylesText.content14BoldWhite,
        backgroundColor: Colors.blue,
        selectedIndex: cIndex,
        onTap: (value) {
          setState(() {
            cIndex = value;
          });
        },
        items: [
          BottomBarItem(
            inactiveColor: Colors.white.withOpacity(.5),
            icon: Icon(Icons.rss_feed_rounded),
            title: Text('breaking'.tr),
            activeColor: Colors.white,
          ),
          BottomBarItem(
            inactiveColor: Colors.white.withOpacity(.5),
            icon: Icon(Icons.assignment_outlined),
            title: Text('news'.tr),
            activeColor: Colors.white,
          ),
          BottomBarItem(
            inactiveColor: Colors.white.withOpacity(.5),
            icon: Icon(Icons.admin_panel_settings_outlined),
            title: Text('community'.tr),
            activeColor: Colors.white,
          ),
          BottomBarItem(
            inactiveColor: Colors.white.withOpacity(.5),
            icon: Icon(Icons.settings_suggest_outlined),
            title: Text('profile'.tr),
            activeColor: Colors.white,
          ),
        ],
      ),
      body: IndexedStack(
        index: cIndex,
        children: _widgetOptions,
      ),
    );
  }
}
