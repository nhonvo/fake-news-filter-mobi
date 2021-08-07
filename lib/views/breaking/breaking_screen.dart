import 'package:fake_news/data/story_data.dart';
import 'package:fake_news/resources/utils/dimension.dart';
import 'package:fake_news/resources/utils/image.dart';
import 'package:fake_news/resources/utils/style.dart';
import 'package:fake_news/resources/widgets/card_news.dart';
import 'package:fake_news/resources/widgets/story_button.dart';
import 'package:flutter/material.dart';

class BreakingScreen extends StatefulWidget {
  const BreakingScreen({Key? key}) : super(key: key);

  @override
  _BreakingScreenState createState() => _BreakingScreenState();
}

class _BreakingScreenState extends State<BreakingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: Colors.white,
            width: double.infinity,
            height: Dimension.getHeight(0.12),
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
                  CardNews(
                      factCheck: Images.icnone,
                      rate: true,
                      tag: '#covid',
                      offical: '18%',
                      user: '25%',
                      times: '5 hours',
                      title:
                          '110.7 milion vaccine does have now been administered in the U.S., up from 109.1 milion on Monday, according to CDC data.',
                      article: 'Reuters U.S. News',
                      onpress: () {}),
                  CardNews(
                      factCheck: Images.icprotect,
                      rate: true,
                      tag: '#covid',
                      offical: '50%',
                      user: '56%',
                      times: '7 hours',
                      image: Images.chart,
                      title:
                          '57,083 cases and 751 deaths were reported in the U.S yesterday, bringing the total to 29.5 milion cases and 536,433 deaths.',
                      article: 'CNN News',
                      onpress: () {}),
                  CardNews(
                      factCheck: Images.icprotect,
                      rate: true,
                      tag: '#covid',
                      offical: '52%',
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
                      offical: '18%',
                      user: '25%',
                      times: '10 hours',
                      title:
                          '110.7 milion vaccine does have now been administered in the U.S., up from 109.1 milion on Monday, according to CDC data.',
                      article: 'Reuters U.S. News',
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
