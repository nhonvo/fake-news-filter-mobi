// ignore_for_file: prefer_const_constructors
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fake_news/resources/utils/app_helper.dart';
import 'package:fake_news/resources/utils/image.dart';
import 'package:fake_news/resources/utils/style.dart';
import 'package:fake_news/resources/widgets/card_news.dart';
import 'package:fake_news/resources/widgets/tag.dart';
import 'package:fake_news/views/breaking/breaking_viewmodel.dart';
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
  PreviewViewModel get previewViewModel => Get.find<PreviewViewModel>();
  BreakingViewModel get breakingViewModel => Get.find<BreakingViewModel>();

  bool follow = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(color: MyColors.card1),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                previewViewModel.topicModel.value.thumbImage != null
                    ? CachedNetworkImage(
                        fit: BoxFit.fitWidth,
                        height: 120,
                        imageUrl:
                            "${previewViewModel.topicModel.value.thumbImage}",
                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        placeholder: (context, url) =>
                            CupertinoActivityIndicator(),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      )
                    : Container(),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TagTopic(
                        tagName:
                            previewViewModel.topicModel.value.tag.toString(),
                        buttonColor: MyColors.red.withOpacity(0.1),
                      ),
                      InkWell(
                        onTap: () {
                          previewViewModel.handleFollowing();
                        },
                        child: TagTopic(
                          tagName: 'follow'.tr,
                          buttonColor: MyColors.red.withOpacity(0.1),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
                  child: Text(
                    previewViewModel.topicModel.value.description.toString(),
                    style: StylesText.content12BlackWhite,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, bottom: 15),
                  child: Row(
                    children: [
                      Icon(FontAwesomeIcons.syncAlt,
                          size: 15, color: Colors.white),
                      SizedBox(width: 10),
                      Text('updateLive'.tr,
                          style: StylesText.content12BoldWhite)
                    ],
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Stack(
              alignment: Alignment.center,
              children: [
                SingleChildScrollView(
                  child: Obx(() {
                    return Column(
                      children: [
                        Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: [
                            for (var item in previewViewModel.news)
                              CardNews(
                                  newsId: item.newsId.toString(),
                                  factCheck: Images.icnone,
                                  rate: true,
                                  socialBeliefs: '${item.socialBeliefs}%',
                                  times: AppHelper.convertToAgo(DateTime.parse(
                                      item.timestamp.toString())),
                                  title:
                                      '${item.title.toString().substring(0, item.title!.length > 50 ? 50 : item.title.toString().length)}...',
                                  content: item.content.toString(),
                                  imageUrl: item.thumbNews.toString(),
                                  webUrl: item.url.toString(),
                                  article: item.publisher ?? '',
                                  viewCount: item.viewCount.toString(),
                                  onPress: () {
                                    breakingViewModel
                                        .handleGetCountView(item.newsId!);
                                  }),
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
          ),
        ],
      ),
    );
  }
}
