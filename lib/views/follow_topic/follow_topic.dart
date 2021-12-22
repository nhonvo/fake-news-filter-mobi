import 'package:fake_news/resources/utils/app_helper.dart';
import 'package:fake_news/resources/utils/image.dart';
import 'package:fake_news/resources/utils/style.dart';
import 'package:fake_news/resources/widgets/button.dart';
import 'package:fake_news/resources/widgets/card.dart';
import 'package:fake_news/views/language/choose_language_screen.dart';
import 'package:fake_news/views/discovery/discovery_viewmodel.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class FollowTopicScreen extends StatefulWidget {
  const FollowTopicScreen({Key? key}) : super(key: key);

  @override
  _FollowTopicScreenState createState() => _FollowTopicScreenState();
}

class _FollowTopicScreenState extends State<FollowTopicScreen> {
  DiscoveryViewModel get viewModel => Get.find<DiscoveryViewModel>();

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
            Positioned(
              top: Get.size.height * 0.001,
              left: Get.size.width * 0.75,
              child: CustomButton(
                width: Get.size.width * 0.2,
                buttonText: 'klanguage'.tr,
                buttonColor: MyColors.blueLight,
                buttonRadius: 10,
                textStyle: StylesText.content12MediumBlue,
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return ChooseLanguageScreen();
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  );
                },
              ),
            ),
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
                  if (viewModel.topicIdListHasFollowed.length < 4) {
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
                    int index = 0;
                    return GridView.count(
                        //shrinkWrap: true,
                        crossAxisCount: 2,
                        children: viewModel.topics.map((topic) {
                          //index used to random color card
                          index++;
                          return Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: CustomCard(
                                index: index.toString(),
                                id: topic.topicId.toString(),
                                isSelected: viewModel.topicIdListHasFollowed.contains(topic.topicId) ? true : false,
                                noNews: topic.noNews.toString(),
                                label: topic.label.toString(),
                                tag: topic.tag.toString(),
                                description: topic.description.toString(),
                                image: topic.thumbImage.toString(),
                                time: AppHelper.convertToAgo(DateTime.parse(topic.realTime.toString())),
                              ));
                        }).toList());
                  }),
                ),
              ],
            ),
            Positioned.fill(
              bottom: 15,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Obx(() {
                  if (viewModel.topicIdListHasFollowed.length < 4) {
                    return Container();
                  } else {
                    return CustomButton(
                      width: Get.size.width * 0.3,
                      buttonText: 'OK',
                      textStyle: StylesText.content14BoldBlue,
                      buttonColor: Colors.white,
                      buttonRadius: 20,
                      onPressed: () {
                        viewModel.handleCreateFollow();
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
