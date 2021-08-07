// ignore_for_file: prefer_const_constructors
import 'package:bottom_animation/bottom_animation.dart';
import 'package:bottom_animation/source/bottomnav_item.dart';
import 'package:fake_news/resources/utils/image.dart';
import 'package:fake_news/resources/utils/style.dart';
import 'package:fake_news/views/breaking/breaking_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var items = <BottomNavItem>[
    BottomNavItem(title: 'Home', iconData: CupertinoIcons.home),
    BottomNavItem(title: 'News', iconData: CupertinoIcons.news),
    BottomNavItem(title: 'Search', iconData: CupertinoIcons.search),
    BottomNavItem(title: 'Profile', iconData: CupertinoIcons.person),
  ];

  static const List<Widget> _widgetOptions = <Widget>[
    BreakingScreen(),
    Text(
      'Index 1: News',
    ),
    Text(
      'Index 2: Search',
    ),
    Text(
      'Index 3: Settings',
    ),
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
            Text("Fake News Filter", style: StylesText.content16BoldWhite)
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
        itemHoverWidth: 130,
        itemHoverBorderRadius: 40,
      ),
      body: Center(
        child: _widgetOptions.elementAt(cIndex),
      ),
    );
  }
}
