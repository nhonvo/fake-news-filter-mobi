import 'package:fake_news/data/story_data.dart';
import 'package:fake_news/models/news/news_model.dart';
import 'package:fake_news/resources/utils/app_helper.dart';
import 'package:fake_news/resources/utils/image.dart';
import 'package:fake_news/resources/widgets/card_news.dart';
import 'package:fake_news/resources/widgets/story_button.dart';
import 'package:fake_news/views/breaking/breaking_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BreakingScreen extends StatefulWidget {
  const BreakingScreen({Key? key}) : super(key: key);

  @override
  _BreakingScreenState createState() => _BreakingScreenState();
}

class _BreakingScreenState extends State<BreakingScreen> {
  BreakingViewModel get viewmodel => Get.find<BreakingViewModel>();
  List<NewsModel> newsList = <NewsModel>[];
  bool isLoaded = false;

  @override
  void initState() {
    super.initState();
    viewmodel.handleGetNewsByFollowedTopic().then((value) {
      setState(() {
        newsList = viewmodel.news;
        isLoaded = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: Colors.white,
            width: double.infinity,
            height: 100,
            alignment: Alignment.center,
            child: ListView.builder(
                itemCount: news.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return storyButton(news[index], context);
                }),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  if (isLoaded)
                    for (var item in newsList)
                      CardNews(
                          factCheck: Images.icnone,
                          rate: true,
                          // tag: viewmodel.topicModel.value.tag.toString(),
                          user: '25%',
                          times: AppHelper.convertToAgo(DateTime.parse(item.timestamp.toString())),
                          title: item.description.toString().substring(
                              0, item.description.toString().length > 50 ? 50 : item.description.toString().length),
                          content: item.content.toString(),
                          article: item.publisher ?? '',
                          onpress: () {}),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}



// CardNews(
//                         factCheck: Images.icnone,
//                         rate: true,
//                         // tag: viewmodel.topicModel.value.tag.toString(),
//                         user: '25%',
//                         times: AppHelper.convertToAgo(DateTime.parse(item.timestamp.toString())),
//                         title: item.description.toString().substring(
//                             0, item.description.toString().length > 50 ? 50 : item.description.toString().length),
//                         content: item.content.toString(),
//                         article: item.publisher ?? '',
//                         onpress: () {}),