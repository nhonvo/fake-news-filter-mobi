import 'package:fake_news/resources/utils/style.dart';
import 'package:fake_news/resources/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import '../../resources/utils/app_routes.dart';
import '../../resources/utils/image.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: IntroductionScreen(
        globalBackgroundColor: Colors.white,
        showBackButton: false,
        showSkipButton: true,
        skip: Text("skip".tr),
        next: Text("next".tr),
        done: Text("done".tr,
            style: TextStyle(
              fontWeight: FontWeight.w600,
            )),
        onDone: () {
          Get.offAllNamed(Routes.DISCOVERY);
        },
        dotsDecorator: DotsDecorator(
            size: Size.square(10.0),
            activeSize: Size(20.0, 10.0),
            color: Colors.black26,
            spacing: EdgeInsets.symmetric(horizontal: 3.0),
            activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0))),
        pages: [
          PageViewModel(
            title: "onboardTitle1".tr,
            body: "onboardBody1".tr,
            image: Image.asset(
              Images.onboarding_1,
              width: Get.size.width * 0.6,
            ),
            decoration: PageDecoration(
              titleTextStyle: StylesText.content24BoldBlue,
              bodyTextStyle: StylesText.content16MediumBlack,
            ),
          ),
          PageViewModel(
            title: "onboardTitle2".tr,
            body: "onboardBody2".tr,
            image: Image.asset(
              Images.onboarding_2,
              width: Get.size.width * 0.6,
            ),
            decoration: PageDecoration(
              titleTextStyle: StylesText.content24BoldBlue,
              bodyTextStyle: StylesText.content16MediumBlack,
            ),
          ),
          PageViewModel(
            title: "onboardTitle3".tr,
            body: "onboardBody3".tr,
            image: Image.asset(
              Images.onboarding_4,
              width: Get.size.width * 0.6,
            ),
            decoration: PageDecoration(
              titleTextStyle: StylesText.content24BoldBlue,
              bodyTextStyle: StylesText.content16MediumBlack,
            ),
          ),
          PageViewModel(
            title: "onboardTitle4".tr,
            body: "onboardBody4".tr,
            image: Image.asset(
              Images.onboarding_5,
              width: Get.size.width * 0.6,
            ),
            footer: CustomButton(
                onPressed: () {
                  OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
                    print("Accepted permission: $accepted");
                  });
                },
                buttonColor: MyColors.blue,
                width: Get.size.width * 0.6,
                buttonText: "allowNotification".tr,
                textStyle: StylesText.content12BoldWhite,
                buttonRadius: 15.0),
            decoration: PageDecoration(
              titleTextStyle: StylesText.content24BoldBlue,
              bodyTextStyle: StylesText.content16MediumBlack,
            ),
          )
        ],
      ),
    );
  }
}
