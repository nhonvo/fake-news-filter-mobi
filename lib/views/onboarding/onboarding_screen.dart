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
        skip: Text("Skip"),
        next: Text("Next"),
        done: Text("Done", style: TextStyle(fontWeight: FontWeight.w600)),
        onDone: () {
          Get.offAllNamed(Routes.DISCOVERY);
        },
        dotsDecorator: DotsDecorator(
            size: Size.square(10.0),
            activeSize: Size(20.0, 10.0),
            color: Colors.black26,
            spacing: EdgeInsets.symmetric(horizontal: 3.0),
            activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0))),
        pages: [
          PageViewModel(
            title: "XEM TIN TỨC",
            body:
                "Đa dạng các chủ đề, ngôn ngữ. \nĐọc các tin tức dựa trên chủ đề đã theo dõi.",
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
            title: "TIN TỨC ĐƯỢC XÁC THỰC",
            body:
                "Các tin tức giả sẽ được lọc và thể hiện cụ thể ở từng tin tức, tránh các tin không đáng tin cậy.",
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
            title: "TƯƠNG TÁC TRÊN TIN TỨC",
            body:
                "Người dùng có thể bình chọn, chia sẻ, bình luận hoặc đóng góp tính xác thực của các tin tức.",
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
            title: "NHẬN THÔNG BÁO MỚI",
            body:
                "Các tin tức mới sẽ được cập nhật để đạt trải nghiệm tốt nhất cho người dùng.",
            image: Image.asset(
              Images.onboarding_5,
              width: Get.size.width * 0.6,
            ),
            footer: CustomButton(
                onPressed: () {
                  OneSignal.shared
                      .promptUserForPushNotificationPermission()
                      .then((accepted) {
                    print("Accepted permission: $accepted");
                  });
                },
                buttonColor: MyColors.blue,
                width: Get.size.width * 0.6,
                buttonText: "Cho phép gửi thông báo",
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
