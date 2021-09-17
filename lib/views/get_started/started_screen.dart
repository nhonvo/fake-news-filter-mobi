// ignore_for_file: prefer_const_constructors

import 'package:fake_news/resources/utils/image.dart';
import 'package:fake_news/resources/utils/style.dart';
import 'package:fake_news/resources/widgets/button.dart';
import 'package:fake_news/resources/widgets/card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class GetStartedScreen extends StatefulWidget {
  const GetStartedScreen({Key? key}) : super(key: key);

  @override
  _GetStartedScreenState createState() => _GetStartedScreenState();
}

class _GetStartedScreenState extends State<GetStartedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: 45),
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
            Colors.blue,
            Colors.white,
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
        ),
        child: Stack(
          children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      Images.logo,
                      width: Get.size.width * 0.2,
                    ),
                    Text('appname'.tr, style: StylesText.content18BoldWhite)
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    'content_started'.tr,
                    style: StylesText.content16BoldWhite,
                    textAlign: TextAlign.center,
                  ),
                ),
                Text(
                  'tap'.tr,
                  style: StylesText.content16BoldRed,
                ),
                Expanded(
                  child: GridView.count(
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    children: List.generate(10, (index) {
                      return Padding(
                        padding: EdgeInsets.all(15.0),
                        child: CustomCard(),
                      );
                    }),
                  ),
                ),
              ],
            ),
            Positioned.fill(
              bottom: 15,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: CustomButton(
                  width: Get.size.width * 0.3,
                  buttonText: 'OK',
                  textStyle: StylesText.content14BoldBlue,
                  buttonColor: Colors.white,
                  buttonRadius: 20,
                  onPressed: () {
                    Get.offAllNamed('/home');
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
