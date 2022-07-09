import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:fake_news/resources/utils/image.dart';
import 'package:fake_news/resources/utils/style.dart';
import 'package:bottom_bar/bottom_bar.dart';

class ComingSoonScreen extends StatelessWidget {
  const ComingSoonScreen({Key? key}) : super(key: key);

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
      bottomNavigationBar: BottomBar(
        textStyle: StylesText.content14BoldWhite,
        backgroundColor: Colors.blue,
        selectedIndex: 3,
        onTap: (value) {},
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
      body: Container(
        alignment: Alignment.center,
        width: double.infinity,
        child: Image.asset(
          Images.coming_soon,
        ),
      ),
    );
  }
}
