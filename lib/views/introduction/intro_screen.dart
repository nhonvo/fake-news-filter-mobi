// ignore_for_file: prefer_const_constructors
import 'package:fake_news/resources/utils/app_helper.dart';
import 'package:fake_news/resources/utils/app_routes.dart';
import 'package:fake_news/resources/utils/image.dart';
import 'package:fake_news/resources/utils/style.dart';
import 'package:fake_news/resources/widgets/button.dart';
import 'package:fake_news/resources/widgets/card_topic.dart';
import 'package:fake_news/views/introduction/intro_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

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
      body: SmartRefresher(
        controller: viewmodel.refreshController,
        onRefresh: viewmodel.onRefresh,
        enablePullDown: true,
        header: MaterialClassicHeader(),
        child: Container(
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
                                    time: AppHelper.convertToAgo(DateTime.parse(topic.realTime.toString())),
                                    ontap: () {
                                      print(topic.topicId);
                                      Get.toNamed(Routes.PREVIEW, arguments: topic.obs);
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
      ),
    );
  }
}
