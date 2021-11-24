// ignore_for_file: prefer_const_constructors
import 'package:fake_news/resources/utils/app_routes.dart';
import 'package:fake_news/resources/utils/image.dart';
import 'package:fake_news/resources/utils/style.dart';
import 'package:fake_news/resources/widgets/button.dart';
import 'package:fake_news/resources/widgets/card_topic.dart';
import 'package:fake_news/views/introduction/intro_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class IntroductionScreen extends StatefulWidget {
  const IntroductionScreen({Key? key}) : super(key: key);

  @override
  _IntroductionScreenState createState() => _IntroductionScreenState();
}

class _IntroductionScreenState extends State<IntroductionScreen> {
  IntroViewModel get viewmodel => Get.find<IntroViewModel>();

  @override
  void initState() {
    super.initState();
    viewmodel.handleGetTopic();
  }

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
                    'introduction'.tr,
                    style: StylesText.content16BoldWhite,
                    textAlign: TextAlign.center,
                  ),
                ),
                CustomButton(
                  width: Get.size.width * 0.4,
                  buttonText: 'started',
                  buttonColor: MyColors.green,
                  buttonRadius: 18.5,
                  textStyle: StylesText.content14BoldWhite,
                  onPressed: () {
                    Get.toNamed(Routes.LOGIN);
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'covering'.tr,
                  style: StylesText.content14BoldWhite,
                ),
                Expanded(
                  child: Obx(() {
                    return GridView.count(
                        //shrinkWrap: true,
                        crossAxisCount: 2,
                        children: viewmodel.topics
                            .map((topic) => Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: CardTopic(
                                  noNews: topic.noNews.toString(),
                                  label: topic.label.toString(),
                                  tag: topic.tag.toString(),
                                  description: topic.description.toString(),
                                  time: convertToAgo(DateTime.tryParse(topic.realTime.toString()) ?? DateTime.now()),
                                  ontap: () {
                                    // Get.toNamed(Routes.TOPIC, arguments: topic);
                                  },
                                )))
                            .toList());
                  }),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  String convertToAgo(DateTime input) {
    Duration diff = DateTime.now().difference(input);
    if (diff.inDays >= 1) {
      if (diff.inDays >= 31) {
        return '${diff.inDays ~/ 31} months ago';
      } else {
        return '${diff.inDays} days ago';
      }
    } else if (diff.inHours >= 1) {
      return '${diff.inHours} hour(s)';
    } else if (diff.inMinutes >= 1) {
      return '${diff.inMinutes} minute(s)';
    } else if (diff.inSeconds >= 1) {
      return '${diff.inSeconds} second(s)';
    } else {
      return 'just now';
    }
  }
}
