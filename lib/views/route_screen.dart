import 'package:fake_news/resources/utils/dimension.dart';
import 'package:fake_news/resources/utils/style.dart';
import 'package:fake_news/resources/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RouteScreen extends StatelessWidget {
  const RouteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomButton(
              width: Dimension.getWidth(0.5),
              height: 20.0,
              buttonText: "1. WIDGET TEST",
              buttonColor: MyColors.red,
              buttonRadius: 14,
              textStyle: StylesText.content18BoldWhite,
              onPressed: () {
                Get.toNamed('/widgets');
              },
            ),
            const SizedBox(
              height: 20,
            ),
            CustomButton(
              width: Dimension.getWidth(0.5),
              height: 20.0,
              buttonText: "2. LOGIN",
              buttonColor: MyColors.red,
              buttonRadius: 14,
              textStyle: StylesText.content18BoldWhite,
              onPressed: () {
                Get.toNamed('/login');
              },
            ),
            const SizedBox(
              height: 20,
            ),
            CustomButton(
              width: Dimension.getWidth(0.5),
              height: 20.0,
              buttonText: "2. GET STARTED",
              buttonColor: MyColors.red,
              buttonRadius: 14,
              textStyle: StylesText.content18BoldWhite,
              onPressed: () {
                Get.toNamed('/getstarted');
              },
            )
          ],
        ),
      ),
    );
  }
}
