import 'package:fake_news/resources/utils/app_helper.dart';
import 'package:fake_news/resources/utils/app_routes.dart';
import 'package:fake_news/resources/utils/icon.dart';
import 'package:fake_news/resources/utils/style.dart';
import 'package:fake_news/resources/widgets/card_community.dart';
import 'package:fake_news/views/community/community_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({Key? key}) : super(key: key);

  @override
  _CommunityScreenState createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  CommunityViewModel get viewModel => Get.find<CommunityViewModel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SmartRefresher(
        controller: viewModel.refreshController,
        onRefresh: viewModel.onRefresh,
        enablePullDown: true,
        header: MaterialClassicHeader(),
        child: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'checkVerify'.tr,
                  style: StylesText.content18BoldBlack,
                ),
                IconButton(onPressed: () {}, icon: Icon(Icons.history))
              ],
            ),
            InkWell(
              onTap: () => Get.toNamed(Routes.CONTRIBUTE),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    style: BorderStyle.solid,
                    width: 1.0,
                  ),
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                height: 45,
                width: Get.size.width * 0.9,
                child: Center(
                    child: Text(
                  'sendInfo'.tr,
                  style: StylesText.content12LightBlack,
                )),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.backup_outlined,
                      color: Colors.blue,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'addFile'.tr,
                      style: StylesText.content12MediumBlack,
                    )
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.info,
                      color: Colors.blue,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'viewGuide'.tr,
                      style: StylesText.content12MediumBlack,
                    )
                  ],
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.all(10),
              color: Colors.white,
              child: Column(
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(
                        IconsApp.follow,
                        width: 25,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'highlightContributedNews'.tr,
                        style: StylesText.content16BoldBlack,
                      ),
                    ],
                  ),
                  Container(
                    height: 170,
                    child: Obx(() => Center(
                          child: ListView.builder(
                            padding: EdgeInsets.all(10),
                            scrollDirection: Axis.horizontal,
                            physics: BouncingScrollPhysics(),
                            itemCount: viewModel.newsCommList.length,
                            itemBuilder: (context, index) {
                              if (viewModel.newsCommList[index].isPopular == true) {
                                return GestureDetector(
                                  onTap: () {},
                                  child: CardCommunity(
                                    avatar: viewModel.newsCommList[index].publisher?.avatar,
                                    thumbNews: viewModel.newsCommList[index].thumbNews,
                                    title: viewModel.newsCommList[index].title.toString(),
                                    content: viewModel.newsCommList[index].content.toString(),
                                    crowdId: viewModel.newsCommList[index].newsCommunityId.toString(),
                                    nameCrowd: viewModel.newsCommList[index].publisher?.fullName ?? "Anonymous",
                                    numberCrowd: viewModel.newsCommList[index].publisher?.noNewsContributed ?? 0,
                                    onpress: () {},
                                    times: "",
                                  ),
                                );
                              } else {
                                return Container();
                              }
                            },
                          ),
                        )),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Obx(() => Container(
                  width: Get.size.width,
                  padding: EdgeInsets.all(10),
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'newContributedNews'.tr,
                        style: StylesText.content16BoldBlack,
                      ),
                      for (var item in viewModel.newsCommList)
                        CardCommunity(
                          avatar: item.publisher?.avatar,
                          title: item.title.toString(),
                          content: item.content.toString(),
                          thumbNews: item.thumbNews,
                          crowdId: item.newsCommunityId.toString(),
                          nameCrowd: item.publisher?.fullName.toString() ?? "Anonymous",
                          numberCrowd: item.publisher?.noNewsContributed ?? 0,
                          width: Get.size.width,
                          times: AppHelper.convertToAgo(DateTime.parse(item.datePublished.toString())),
                          onpress: () {},
                        ),
                    ],
                  ),
                ))
          ]),
        )),
      ),
    );
  }
}
