// ignore_for_file: prefer_const_constructors

import 'package:fake_news/resources/utils/image.dart';
import 'package:fake_news/resources/utils/style.dart';
import 'package:fake_news/resources/widgets/card_news.dart';
import 'package:fake_news/resources/widgets/tag.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class PreviewScreen extends StatefulWidget {
  const PreviewScreen({Key? key}) : super(key: key);

  @override
  _PreviewScreenState createState() => _PreviewScreenState();
}

class _PreviewScreenState extends State<PreviewScreen> {
  bool follow = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: Get.size.height * 0.29,
                  decoration: BoxDecoration(color: MyColors.card1),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(Images.covid),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TagTopic(
                              tagName: '#covid19',
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
                          'Outbreak of respiratory virus that has killed over 1 milion and infected 100 milion worldwide.',
                          style: StylesText.content12BlackWhite,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Row(
                          children: [
                            Icon(FontAwesomeIcons.syncAlt, size: 15, color: Colors.white),
                            SizedBox(width: 10),
                            Text('UPDATING LIVE', style: StylesText.content14BoldWhite)
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    CardNews(
                        factCheck: Images.icnone,
                        rate: true,
                        tag: '#covid',
                        user: '25%',
                        times: '5 hours',
                        title:
                            '110.7 milion vaccine does have now been administered in the U.S., up from 109.1 milion on Monday, according to CDC data.',
                        article: 'Reuters U.S. News',
                        onpress: () {}),
                    CardNews(
                        factCheck: Images.icnone,
                        rate: true,
                        tag: '#covid',
                        offical: 'Misleading',
                        user: '46%',
                        times: '7 hours',
                        image: Images.chart,
                        title:
                            '57,083 cases and 751 deaths were reported in the U.S yesterday, bringing the total to 29.5 milion cases and 536,433 deaths.',
                        article: 'CNN News',
                        onpress: () {}),
                    CardNews(
                        factCheck: Images.icprotect,
                        tag: '#covid',
                        offical: 'True',
                        user: '60%',
                        times: '9 hours',
                        title:
                            '"I would, I would recommend [the vaccine]. And I would recommend it to a lot of people that dont want to get it and a lot of those people voted for me, frankly." ',
                        article: 'CNN News',
                        avatar: Images.trump,
                        name: 'Former President Trump',
                        onpress: () {}),
                    CardNews(
                        factCheck: Images.icnone,
                        rate: true,
                        tag: '#covid',
                        user: '25%',
                        times: '10 hours',
                        title:
                            '110.7 milion vaccine does have now been administered in the U.S., up from 109.1 milion on Monday, according to CDC data.',
                        article: 'Reuters U.S. News',
                        onpress: () {}),
                  ],
                ),
              ],
            ),
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
