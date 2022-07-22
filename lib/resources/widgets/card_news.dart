// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fake_news/providers/auth_repo.dart';
import 'package:fake_news/resources/utils/app_config.dart';
import 'package:fake_news/resources/utils/icon.dart';
import 'package:fake_news/resources/utils/style.dart';
import 'package:fake_news/resources/widgets/tag.dart';
import 'package:fake_news/views/view_news/viewnews_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'button.dart';

class CardNews extends StatefulWidget {
  final String? offical, socialBeliefs, avatar, name, link, imageUrl, video, webUrl;
  final String newsId, times, title, article, content, factCheck;
  final List<String?>? tags;

  final VoidCallback onPress;

  final bool? rate;
  const CardNews(
      {Key? key,
      required this.newsId,
      required this.factCheck,
      this.offical,
      this.socialBeliefs,
      required this.times,
      this.imageUrl,
      this.webUrl,
      this.video,
      required this.title,
      required this.article,
      this.avatar,
      this.name,
      required this.onPress,
      this.link,
      this.tags,
      required this.content,
      this.rate = false})
      : super(key: key);

  @override
  _CardNewsState createState() => _CardNewsState();
}

class _CardNewsState extends State<CardNews> {
  AuthRepo authRepo = Get.find();
  late bool isLoggedIn = false;
  var appEnvironment = Get.find<AppEnvironment>();

  @override
  void initState() {
    super.initState();
    authRepo.getAuthToken().then((token) {
      if (token != null) {
        setState(() {
          isLoggedIn = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            widget.onPress();
            Get.to(() => ViewNewsScreen(
                  newsId: widget.newsId,
                  content: widget.content,
                  webUrl: widget.webUrl,
                  isLoggedIn: isLoggedIn,
                ));
          },
          child: Container(
            padding: EdgeInsets.all(5),
            margin: EdgeInsets.only(top: 10),
            width: Get.size.width * 0.9,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          widget.offical != null && widget.socialBeliefs != null
                              ? SvgPicture.asset(
                                  widget.factCheck,
                                  width: 30,
                                )
                              : SizedBox(),
                          SizedBox(width: 5),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              widget.offical != null
                                  ? Row(children: [
                                      Text('Official Rating: ', style: StylesText.content12MediumBlack),
                                      Text(
                                        widget.offical!,
                                        style: StylesText.content12BoldBlack,
                                      )
                                    ])
                                  : SizedBox(),
                              widget.socialBeliefs != null
                                  ? Row(children: [
                                      widget.offical == null
                                          ? Padding(
                                              padding: const EdgeInsets.only(right: 4.0),
                                              child: SvgPicture.asset(
                                                IconsApp.unknown,
                                                width: 24,
                                              ))
                                          : SizedBox(),
                                      Text(
                                        'Social Beliefs: ',
                                        style: StylesText.content12MediumBlack,
                                      ),
                                      Text(
                                        widget.socialBeliefs!,
                                        style: StylesText.content12BoldBlack,
                                      )
                                    ])
                                  : SizedBox(),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.access_time_rounded,
                            size: 20,
                            color: MyColors.greyDark,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            widget.times,
                            style: StylesText.content12BoldGrey,
                          )
                        ],
                      )
                    ],
                  ),
                  widget.imageUrl != "null"
                      ? Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: CachedNetworkImage(
                              fit: BoxFit.fitWidth,
                              height: 180,
                              imageUrl: widget.imageUrl!,
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
                          ),
                        )
                      : SizedBox(
                          height: 10,
                        ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    widget.title,
                    style: StylesText.content14BoldBlack,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  widget.avatar != null
                      ? Container(
                          margin: EdgeInsets.only(left: 8.0, right: 10),
                          child: CustomIconButton(
                            buttonColor: MyColors.greyLight,
                            onPressed: () {},
                            icon: CircleAvatar(
                              backgroundImage: AssetImage(widget.avatar!),
                              radius: 13,
                            ),
                            buttonRadius: 20,
                            buttonText: widget.name ?? '',
                            textStyle: StylesText.content14BoldGrey,
                          ),
                        )
                      : SizedBox(),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.article,
                        style: StylesText.content12BoldGrey,
                      ),
                      isLoggedIn && widget.rate == true
                          ? SizedBox()
                          // RatingButton(newsId: widget.newsId.toString())
                          : InkWell(
                              onTap: () {},
                              child: Row(
                                children: [
                                  Text(
                                    'read_more'.tr,
                                    style: StylesText.content12BoldGrey,
                                  ),
                                  Icon(
                                    Icons.launch_rounded,
                                    color: MyColors.greyDark,
                                    size: 18,
                                  )
                                ],
                              ),
                            )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        widget.tags == null
            ? SizedBox()
            : Positioned(
                top: 3,
                right: 0,
                child: Row(
                  children: [
                    for (var tag in widget.tags!)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2),
                        child: TagTopic(tagName: tag, buttonColor: Colors.blue),
                      ),
                  ],
                ),
              )
      ],
    );
  }
}
