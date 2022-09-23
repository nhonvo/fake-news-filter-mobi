import 'package:fake_news/resources/utils/app_helper.dart';
import 'package:fake_news/resources/utils/image.dart';
import 'package:fake_news/resources/widgets/card_news.dart';
import 'package:fake_news/resources/widgets/shimmer.dart';
import 'package:fake_news/views/breaking/breaking_viewmodel.dart';
import 'package:fake_news/views/searching/searching_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

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
            padding: const EdgeInsets.only(top: 80.0),
            child: Obx(
              () => viewmodel.isFirstLoadRunning.value
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
                      mainAxisAlignment: MainAxisAlignment.center,
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
                          child: SmartRefresher(
                            controller: viewmodel.refreshController,
                            onRefresh: viewmodel.onRefresh,
                            header: MaterialClassicHeader(),
                            child: ListView.builder(
                              controller: viewmodel.scrollController,
                              itemCount: viewmodel.newsLoadMore.length,
                              itemBuilder: (_, index) => CardNews(
                                  newsId: viewmodel.newsLoadMore[index]!.newsId.toString(),
                                  factCheck: Images.icnone,
                                  rate: true,
                                  tags: viewmodel.newsLoadMore[index]!.topicInfo!.map((v) => v!.topicName).toList(),
                                  socialBeliefs: '${viewmodel.newsLoadMore[index]!.socialBeliefs!.toInt() * 100}%',
                                  times: AppHelper.convertToAgo(
                                      DateTime.parse(viewmodel.newsLoadMore[index]!.timestamp.toString())),
                                  title: viewmodel.newsLoadMore[index]!.title.toString().substring(
                                      0,
                                      viewmodel.newsLoadMore[index]!.title.toString().length > 50
                                          ? 50
                                          : viewmodel.newsLoadMore[index]?.title.toString().length),
                                  imageUrl: viewmodel.newsLoadMore[index]?.thumbNews.toString(),
                                  webUrl: viewmodel.newsLoadMore[index]?.urlNews.toString(),
                                  article: viewmodel.newsLoadMore[index]?.publisher ?? '',
                                  viewCount: viewmodel.newsLoadMore[index]!.viewCount!,
                                  onPress: () {
                                    viewmodel.handleGetCountView(viewmodel.newsLoadMore[index]!.newsId!);
                                  }),
                            ),
                          ),
                        ),

                        // when the _loadMore function is running
                        if (viewmodel.isLoadMoreRunning.value == true)
                          Padding(
                            padding: EdgeInsets.only(top: 10, bottom: 10),
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),

                        // When nothing else to load
                        if (viewmodel.hasNextPage.value == false)
                          Container(
                            padding: const EdgeInsets.only(top: 20, bottom: 20),
                            color: Colors.amber,
                            child: const Center(
                              child: Text('You have fetched all of the content'),
                            ),
                          ),
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
