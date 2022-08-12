import 'package:fake_news/resources/utils/image.dart';
import 'package:fake_news/resources/utils/style.dart';
import 'package:fake_news/views/splash/splash_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Images.background),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SvgPicture.asset(
              Images.logo,
              width: Get.size.width * 0.25,
            ),
            Text('appname'.tr, style: StylesText.content18BoldWhite),
            SizedBox(
              height: 10,
            ),
            Text('slogan'.tr, style: StylesText.content18BoldWhite),
            SizedBox(
              height: 10,
            ),
            RefreshProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
