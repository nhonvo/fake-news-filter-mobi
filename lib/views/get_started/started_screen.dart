// ignore_for_file: prefer_const_constructors

import 'package:fake_news/resources/utils/app_helper.dart';
import 'package:fake_news/resources/utils/image.dart';
import 'package:fake_news/resources/utils/style.dart';
import 'package:fake_news/resources/widgets/button.dart';
import 'package:fake_news/resources/widgets/card.dart';
import 'package:fake_news/views/introduction/intro_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class GetStartedScreen extends StatefulWidget {
  const GetStartedScreen({Key? key}) : super(key: key);

  @override
  _GetStartedScreenState createState() => _GetStartedScreenState();
}

class _GetStartedScreenState extends State<GetStartedScreen> {
  IntroViewModel get viewmodel => Get.find<IntroViewModel>();

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
                    'content_started'.tr,
                    style: StylesText.content16BoldWhite,
                    textAlign: TextAlign.center,
                  ),
                ),
                Obx(() {
                  if (viewmodel.topicIds.length < 4) {
                    return Text(
                      'tap'.tr,
                      style: StylesText.content16BoldRed,
                    );
                  } else {
                    return Text(
                      'started'.tr,
                      style: StylesText.content16BoldWhite,
                    );
                  }
                }),
                Expanded(
                  child: Obx(() {
                    return GridView.count(
                        //shrinkWrap: true,
                        crossAxisCount: 2,
                        children: viewmodel.topics
                            .map((topic) => Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: CustomCard(
                                  id: topic.topicId.toString(),
                                  noNews: topic.noNews.toString(),
                                  label: topic.label.toString(),
                                  tag: topic.tag.toString(),
                                  description: topic.description.toString(),
                                  time: AppHelper.convertToAgo(DateTime.parse(topic.realTime.toString())),
                                )))
                            .toList());
                  }),
                ),
              ],
            ),
            Positioned.fill(
              bottom: 15,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Obx(() {
                  if (viewmodel.topicIds.length < 4) {
                    return Container();
                  } else {
                    return CustomButton(
                      width: Get.size.width * 0.3,
                      buttonText: 'OK',
                      textStyle: StylesText.content14BoldBlue,
                      buttonColor: Colors.white,
                      buttonRadius: 20,
                      onPressed: () {
                        viewmodel.handleCreateFollow();
                      },
                    );
                  }
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
