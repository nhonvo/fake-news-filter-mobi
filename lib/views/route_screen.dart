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
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 50),
        child: Center(
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
                buttonText: "3. INTRODUCTION",
                buttonColor: MyColors.red,
                buttonRadius: 14,
                textStyle: StylesText.content18BoldWhite,
                onPressed: () {
                  Get.toNamed('/introduction');
                },
              ),
              const SizedBox(
                height: 20,
              ),
              CustomButton(
                width: Dimension.getWidth(0.5),
                height: 20.0,
                buttonText: "4. GET STARTED",
                buttonColor: MyColors.red,
                buttonRadius: 14,
                textStyle: StylesText.content18BoldWhite,
                onPressed: () {
                  Get.toNamed('/getstarted');
                },
              ),
              const SizedBox(
                height: 20,
              ),
              CustomButton(
                width: Dimension.getWidth(0.5),
                height: 20.0,
                buttonText: "5. PREVIEW",
                buttonColor: MyColors.red,
                buttonRadius: 14,
                textStyle: StylesText.content18BoldWhite,
                onPressed: () {
                  Get.toNamed('/preview');
                },
              ),
              const SizedBox(
                height: 20,
              ),
              CustomButton(
                width: Dimension.getWidth(0.5),
                height: 20.0,
                buttonText: "6. HOME",
                buttonColor: MyColors.red,
                buttonRadius: 14,
                textStyle: StylesText.content18BoldWhite,
                onPressed: () {
                  Get.toNamed('/home');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
