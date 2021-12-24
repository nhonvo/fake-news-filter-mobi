import 'package:fake_news/resources/utils/image.dart';
import 'package:fake_news/resources/utils/style.dart';
import 'package:fake_news/views/splash/splash_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashViewModel get viewmodel => Get.find<SplashViewModel>();

  @override
  Widget build(BuildContext context) {
    SizeText.queryData = MediaQuery.of(context).textScaleFactor;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
            Colors.blue,
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
                    width: Get.size.width * 0.2,
                  ),
                  Text('appname'.tr, style: StylesText.content18BoldWhite)
                ],
              ),
            ),
            Column(
              children: <Widget>[
                Text("hello".tr, style: StylesText.content18BoldBlack),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
            Image.asset(Images.banner),
          ],
        ),
      ),
    );
  }
}
