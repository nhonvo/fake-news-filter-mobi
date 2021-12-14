// ignore_for_file: prefer_const_constructors

import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fake_news/resources/utils/app_helper.dart';
import 'package:fake_news/resources/utils/image.dart';
import 'package:fake_news/resources/utils/style.dart';
import 'package:fake_news/resources/widgets/card_news.dart';
import 'package:fake_news/resources/widgets/tag.dart';
import 'package:fake_news/views/preview/preview_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class PreviewScreen extends StatefulWidget {
  const PreviewScreen({Key? key}) : super(key: key);

  @override
  _PreviewScreenState createState() => _PreviewScreenState();
}

class _PreviewScreenState extends State<PreviewScreen> {
  PreviewViewModel get viewmodel => Get.find<PreviewViewModel>();

  bool follow = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          SingleChildScrollView(
            child: Obx(() {
              return Column(
                children: [
                  Container(
                    height: Get.size.height * 0.29,
                    decoration: BoxDecoration(color: MyColors.card1),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CachedNetworkImage(
                          fit: BoxFit.fitWidth,
                          height: 120,
                          imageUrl:
                              "${viewmodel.appEnvironment.apiBaseUrl}/images/topics/${viewmodel.topicModel.value.thumbImage}",
                          imageBuilder: (context, imageProvider) => Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          placeholder: (context, url) => CupertinoActivityIndicator(),
                          errorWidget: (context, url, error) => Icon(Icons.error),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TagTopic(
                                tagName: viewmodel.topicModel.value.tag.toString(),
                                buttonColor: MyColors.red.withOpacity(0.1),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    follow = !follow;
                                  });
                                },
                                child: TagTopic(
                                  tagName: follow ? '  + FOLLOWING   ' : '  + FOLLOW   ',
                                  buttonColor: MyColors.red.withOpacity(0.1),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
                          child: Text(
                            viewmodel.topicModel.value.description.toString(),
                            style: StylesText.content12BlackWhite,
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: Row(
                              children: [
                                Icon(FontAwesomeIcons.syncAlt, size: 15, color: Colors.white),
                                SizedBox(width: 10),
                                Text('UPDATING LIVE', style: StylesText.content14BoldWhite)
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      for (var item in viewmodel.news)
                        CardNews(
                            newsId: item.newsId.toString(),
                            factCheck: Images.icnone,
                            rate: true,
                            user: '${50 + new Random().nextInt(90 - 50)}%',
                            times: AppHelper.convertToAgo(DateTime.parse(item.timestamp.toString())),
                            title: item.description.toString().substring(
                                0, item.description.toString().length > 50 ? 50 : item.description.toString().length),
                            content: item.content.toString(),
                            image: item.thumbNews.toString(),
                            article: item.publisher ?? '',
                            onpress: () {}),
                    ],
                  ),
                ],
              );
            }),
          ),
          Positioned(
              bottom: 15,
              child: CircleAvatar(
                  child: IconButton(
                    tooltip: 'Close',
                    icon: Icon(Icons.close),
                    color: Colors.white,
                    onPressed: () {
                      Get.back();
                    },
                  ),
                  radius: 30,
                  backgroundColor: MyColors.blue.withOpacity(0.8))),
        ],
      ),
    );
  }
}
