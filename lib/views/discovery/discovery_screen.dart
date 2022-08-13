// ignore_for_file: prefer_const_constructors
import 'package:fake_news/resources/utils/app_helper.dart';
import 'package:fake_news/resources/utils/app_routes.dart';
import 'package:fake_news/resources/utils/image.dart';
import 'package:fake_news/resources/utils/style.dart';
import 'package:fake_news/resources/widgets/button.dart';
import 'package:fake_news/resources/widgets/card_topic.dart';
import 'package:fake_news/views/discovery/discovery_viewmodel.dart';
import 'package:fake_news/views/language/choose_language_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class DiscoveryScreen extends StatefulWidget {
  const DiscoveryScreen({Key? key}) : super(key: key);

  @override
  _DiscoveryScreenState createState() => _DiscoveryScreenState();
}

class _DiscoveryScreenState extends State<DiscoveryScreen> {
  DiscoveryViewModel get viewmodel => Get.find<DiscoveryViewModel>();

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
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        Images.logo,
                        width: Get.size.width * 0.25,
                      ),
                      Text('appname'.tr, style: StylesText.content16BoldWhite)
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
                      int index = 0;
                      return GridView.count(
                          shrinkWrap: true,
                          crossAxisCount: 2,
                          children: viewmodel.topics.map((topic) {
                            index++;
                            return Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: CardTopic(
                                  index: index.toString(),
                                  noNews: topic.noNews.toString(),
                                  label: topic.label.toString(),
                                  tag: topic.tag.toString(),
                                  description: topic.description.toString(),
                                  image: topic.thumbImage.toString(),
                                  time: AppHelper.convertToAgo(DateTime.parse(
                                      topic.realTime.toString())),
                                  ontap: () {
                                    Get.toNamed(Routes.PREVIEW,
                                        arguments: topic.obs);
                                  },
                                ));
                          }).toList());
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
