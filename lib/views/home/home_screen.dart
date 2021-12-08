// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables
import 'package:fake_news/resources/utils/image.dart';
import 'package:fake_news/resources/utils/style.dart';
import 'package:fake_news/resources/widgets/bottomnav_item.dart';
import 'package:fake_news/resources/widgets/navigation_bar.dart';
import 'package:fake_news/views/breaking/breaking_screen.dart';
import 'package:fake_news/views/profile_setting/profile_setting_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var items = <BottomNavItem>[
    BottomNavItem(title: 'breaking'.tr, iconData: Icons.rss_feed_rounded),
    BottomNavItem(title: 'news'.tr, iconData: CupertinoIcons.news),
    BottomNavItem(title: 'search'.tr, iconData: CupertinoIcons.search),
    BottomNavItem(title: 'profile'.tr, iconData: CupertinoIcons.person),
  ];

  static const List<Widget> _widgetOptions = <Widget>[
    BreakingScreen(),
    Text(
      'Index 1: News',
    ),
    Text(
      'Index 2: Search',
    ),
    ProfileScreen(),
  ];

  var cIndex;

  @override
  void initState() {
    cIndex = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              Images.logo,
              width: 30,
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
      bottomNavigationBar: BottomAnimation(
        barHeight: 70,
        selectedIndex: cIndex,
        items: items,
        backgroundColor: Colors.blue,
        onItemSelect: (value) {
          setState(() {
            cIndex = value;
          });
        },
        itemHoverColor: Colors.white,
        itemHoverColorOpacity: .9,
        activeIconColor: Colors.blue,
        deActiveIconColor: Colors.white.withOpacity(.9),
        textStyle: TextStyle(
          color: Colors.blue,
          fontWeight: FontWeight.bold,
        ),
        itemHoverHeight: 45,
        itemHoverWidth: Get.size.width * 0.3,
        itemHoverBorderRadius: 20,
      ),
      body: IndexedStack(
        index: cIndex,
        children: _widgetOptions,
      ),
    );
  }
}
