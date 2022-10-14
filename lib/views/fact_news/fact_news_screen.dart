import 'package:fake_news/resources/utils/app_helper.dart';
import 'package:fake_news/resources/utils/icon.dart';
import 'package:fake_news/resources/utils/style.dart';
import 'package:fake_news/resources/widgets/button.dart';
import 'package:fake_news/resources/widgets/card_news.dart';
import 'package:fake_news/views/breaking/breaking_viewmodel.dart';
import 'package:fake_news/views/fact_news/fact_news_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../resources/utils/image.dart';
import '../../resources/widgets/shimmer.dart';
import '../../resources/widgets/snackbar_custom.dart';

class FactNewsScreen extends StatefulWidget {
  const FactNewsScreen({Key? key}) : super(key: key);

  @override
  _FactNewsScreenState createState() => _FactNewsScreenState();
}

class _FactNewsScreenState extends State<FactNewsScreen> {
  FactNewsViewModel get factNewsViewModel => Get.find<FactNewsViewModel>();
  BreakingViewModel get breakingViewModel => Get.find<BreakingViewModel>();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildHeader(),
        Expanded(
          child: _buildBody(),
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
          Obx(
            () => Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.transparent,
              ),
              width: 305,
              height: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  factNewsViewModel.index.value == 0
                      ? CustomButton(
                          buttonText: 'real'.tr.toUpperCase(),
                          buttonColor: MyColors.blue,
                          buttonRadius: 30,
                          width: 150,
                          textStyle: StylesText.content14BoldWhite,
                          onPressed: () => factNewsViewModel.index.value = 0,
                        )
                      : CustomButton(
                          buttonText: 'real'.tr.toUpperCase(),
                          buttonColor: MyColors.greyLight,
                          buttonRadius: 30,
                          width: 150,
                          textStyle: StylesText.content12BoldWhite,
                          onPressed: () {
                            factNewsViewModel
                              ..index.value = 0
                              ..filter.value = 'real'
                              ..resetPaging()
                              ..firstLoad();
                          },
                        ),
                  factNewsViewModel.index.value == 1
                      ? CustomButton(
                          buttonText: 'fake'.tr.toUpperCase(),
                          buttonColor: MyColors.blue,
                          buttonRadius: 30,
                          width: 150,
                          textStyle: StylesText.content14BoldWhite,
                          onPressed: () => factNewsViewModel.index.value = 1)
                      : CustomButton(
                          buttonText: 'fake'.tr.toUpperCase(),
                          buttonColor: MyColors.greyLight,
                          buttonRadius: 30,
                          width: 150,
                          textStyle: StylesText.content12BoldWhite,
                          onPressed: () {
                            factNewsViewModel
                              ..index.value = 1
                              ..filter.value = 'fake'
                              ..resetPaging()
                              ..firstLoad();
                          },
                        )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    if (factNewsViewModel.index.value == 0) {
      return _buildItem('real');
    } else {
      return _buildItem('fake');
    }
  }

  Widget _buildItem(String filter) {
    return Obx(
      () => factNewsViewModel.isFirstLoadRunning.value
          ? Container(
              height: 700,
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  padding: const EdgeInsets.all(8),
                  itemCount: 6,
                  itemBuilder: (BuildContext context, int index) {
                    return NewsShimmer();
                  }),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    controller: factNewsViewModel.scrollController,
                    itemCount: factNewsViewModel.news.length,
                    itemBuilder: (_, index) => CardNews(
                        newsId: factNewsViewModel.news[index]!.newsId.toString(),
                        factCheck: factNewsViewModel.index.value == 0 ? IconsApp.real : IconsApp.fake,
                        rate: false,
                        offical: factNewsViewModel.index.value == 0 ? "real".tr : "fake".tr,
                        tags: factNewsViewModel.news[index]!.topicInfo!.map((v) => v!.topicName).toList(),
                        socialBeliefs: '${factNewsViewModel.news[index]!.socialBeliefs!.toInt() * 100}%',
                        times:
                            AppHelper.convertToAgo(DateTime.parse(factNewsViewModel.news[index]!.timestamp.toString())),
                        title: factNewsViewModel.news[index]!.title.toString().substring(
                            0,
                            factNewsViewModel.news[index]!.title.toString().length > 50
                                ? 50
                                : factNewsViewModel.news[index]?.title.toString().length),
                        imageUrl: factNewsViewModel.news[index]?.thumbNews.toString(),
                        webUrl: factNewsViewModel.news[index]?.urlNews.toString(),
                        article: factNewsViewModel.news[index]?.publisher ?? 'Anonymous',
                        viewCount: factNewsViewModel.news[index]!.viewCount!,
                        onPress: () {
                          breakingViewModel.handleGetCountView(factNewsViewModel.news[index]!.newsId!);
                          // factNewsViewModel.handleGetCountView(factNewsViewModel.news[index]!.newsId!);
                        }),
                  ),
                ),
                if (factNewsViewModel.isLoadMoreRunning.value == true)
                  Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    child: Center(
                      child: CupertinoActivityIndicator(),
                    ),
                  ),
              ],
            ),
    );
  }
}
