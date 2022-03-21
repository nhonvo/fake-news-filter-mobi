import 'dart:math';

import 'package:fake_news/data/story_data.dart';
import 'package:fake_news/resources/utils/app_helper.dart';
import 'package:fake_news/resources/utils/image.dart';
import 'package:fake_news/resources/widgets/card_news.dart';
import 'package:fake_news/resources/widgets/shimmer.dart';
import 'package:fake_news/resources/widgets/story_button.dart';
import 'package:fake_news/views/breaking/breaking_viewmodel.dart';
import 'package:fake_news/views/searching/searching_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class BreakingScreen extends StatefulWidget {
  const BreakingScreen({Key? key}) : super(key: key);

  @override
  _BreakingScreenState createState() => _BreakingScreenState();
}

class _BreakingScreenState extends State<BreakingScreen> {
  BreakingViewModel get viewmodel => Get.find<BreakingViewModel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 50.0),
            child: SmartRefresher(
              controller: viewmodel.refreshController,
              onRefresh: viewmodel.onRefresh,
              header: MaterialClassicHeader(),
              child: Column(
                children: [
                  //TODO: Uncomment to enable story

                  // Container(
                  //   color: Colors.white,
                  //   width: double.infinity,
                  //   height: 100,
                  //   alignment: Alignment.center,
                  //   child: ListView.builder(
                  //       itemCount: news.length,
                  //       scrollDirection: Axis.horizontal,
                  //       itemBuilder: (context, index) {
                  //         return storyButton(news[index], context);
                  //       }),
                  // ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Obx(() {
                        return viewmodel.isLoaded.value
                            ? Wrap(
                                spacing: 10,
                                runSpacing: 10,
                                children: [
                                  for (var item in viewmodel.news)
                                    CardNews(
                                        newsId: item!.newsId.toString(),
                                        factCheck: Images.icnone,
                                        rate: true,
                                        // tag: viewmodel.topicModel.value.tag.toString(),
                                        socialBeliefs: '${50 + new Random().nextInt(90 - 50)}%',
                                        times: AppHelper.convertToAgo(DateTime.parse(item.timestamp.toString())),
                                        title: item.description.toString().substring(
                                            0,
                                            item.description.toString().length > 50
                                                ? 50
                                                : item.description.toString().length),
                                        content: item.content.toString(),
                                        image: item.thumbNews.toString(),
                                        article: item.publisher ?? '',
                                        onpress: () {}),
                                ],
                              )
                            : Container(
                                height: 700,
                                child: ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    padding: const EdgeInsets.all(8),
                                    itemCount: 6,
                                    itemBuilder: (BuildContext context, int index) {
                                      return NewsShimmer();
                                    }),
                              );
                      }),
                    ),
                  )
                ],
              ),
            ),
          ),
          Searching(),
        ],
      ),
    );
  }
}
