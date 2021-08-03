import 'package:fake_news/resources/utils/dimension.dart';
import 'package:fake_news/resources/utils/image.dart';
import 'package:fake_news/resources/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () => Get.offNamed('/test'));
  }

  @override
  Widget build(BuildContext context) {
    Dimension.height = MediaQuery.of(context).size.height;
    Dimension.width = MediaQuery.of(context).size.width;
    SizeText.queryData = MediaQuery.of(context).textScaleFactor;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
            MyColors.blueEgg,
            Colors.white,
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(top: 50),
              child: Column(
                children: <Widget>[
                  Image.asset(
                    Images.logo,
                    width: Dimension.getWidth(0.3),
                  ),
                  Text("Fake News Filter", style: StylesText.content18BoldWhite)
                ],
              ),
            ),
            Column(
              children: <Widget>[
                Text("Xin chào", style: StylesText.content16BoldBlack),
                const SizedBox(
                  height: 10,
                ),
                Text("Bùi Phú Khuyên", style: StylesText.content16BoldBlack)
              ],
            ),
            Image.asset(Images.banner),
          ],
        ),
      ),
    );
  }
}
