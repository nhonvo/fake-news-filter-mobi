import 'dart:math';

import 'package:fake_news/resources/utils/app_helper.dart';
import 'package:fake_news/resources/utils/icon.dart';
import 'package:fake_news/resources/utils/style.dart';
import 'package:fake_news/resources/widgets/button.dart';
import 'package:fake_news/resources/widgets/card_news.dart';
import 'package:fake_news/views/fact_news/fact_news_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class FactNewsScreen extends StatefulWidget {
  const FactNewsScreen({Key? key}) : super(key: key);

  @override
  _FactNewsScreenState createState() => _FactNewsScreenState();
}

class _FactNewsScreenState extends State<FactNewsScreen> {
  int index = 0;
  FactNewsViewModel get viewmodel => Get.find<FactNewsViewModel>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildHeader(),
        Expanded(
          child: SingleChildScrollView(
            child: _buildBody(),
          ),
        )
      ],
    );
  }

  Widget _buildHeader() {
    return Center(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          Text('filter_news'.tr.toUpperCase(), style: StylesText.content20BoldBlack),
          SizedBox(
            height: 5,
          ),
          Text('choose_type_filter'.tr, style: StylesText.content14BoldGrey),
          SizedBox(
            height: 10,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.transparent,
            ),
            width: 305,
            height: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                index == 0
                    ? CustomButton(
                        buttonText: 'real'.tr.toUpperCase(),
                        buttonColor: MyColors.blue,
                        buttonRadius: 30,
                        width: 150,
                        textStyle: StylesText.content14BoldWhite,
                        onPressed: () {
                          setState(() {
                            index = 0;
                          });
                        },
                      )
                    : CustomButton(
                        buttonText: 'real'.tr.toUpperCase(),
                        buttonColor: MyColors.greyLight,
                        buttonRadius: 30,
                        width: 150,
                        textStyle: StylesText.content12BoldWhite,
                        onPressed: () {
                          setState(() {
                            index = 0;
                          });
                        },
                      ),
                index == 1
                    ? CustomButton(
                        buttonText: 'fake'.tr.toUpperCase(),
                        buttonColor: MyColors.blue,
                        buttonRadius: 30,
                        width: 150,
                        textStyle: StylesText.content14BoldWhite,
                        onPressed: () {
                          setState(() {
                            index = 0;
                          });
                        },
                      )
                    : CustomButton(
                        buttonText: 'fake'.tr.toUpperCase(),
                        buttonColor: MyColors.greyLight,
                        buttonRadius: 30,
                        width: 150,
                        textStyle: StylesText.content12BoldWhite,
                        onPressed: () {
                          setState(() {
                            index = 1;
                          });
                        },
                      )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    if (index == 0) {
      viewmodel.news.clear();
      viewmodel.handleGetFactNews('real');
      return _buildItem('real');
    } else {
      viewmodel.news.clear();
      viewmodel.handleGetFactNews('fake');
      return _buildItem('fake');
    }
  }

  Widget _buildItem(String filter) {
    return Obx(() {
      return viewmodel.isLoaded.value
          ? Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                for (var item in viewmodel.news)
                  CardNews(
                      newsId: item!.newsId.toString(),
                      factCheck: filter == 'real' ? IconsApp.real : IconsApp.fake,
                      rate: false,
                      offical: "$filter".tr,
                      // tag: viewmodel.topicModel.value.tag.toString(),
                      socialBeliefs: '${50 + new Random().nextInt(90 - 50)}%',
                      times: AppHelper.convertToAgo(DateTime.parse(item.timestamp.toString())),
                      title: item.description.toString().substring(
                          0, item.description.toString().length > 50 ? 50 : item.description.toString().length),
                      content: item.content.toString(),
                      image: item.thumbNews.toString(),
                      article: item.publisher ?? '',
                      onpress: () {}),
              ],
            )
          : Container();
    });
  }
}
