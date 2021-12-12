// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fake_news/providers/auth_repo.dart';
import 'package:fake_news/resources/utils/app_config.dart';
import 'package:fake_news/resources/utils/style.dart';
import 'package:fake_news/resources/widgets/rating.dart';
import 'package:fake_news/views/view_news/viewnews_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'button.dart';

class CardNews extends StatefulWidget {
  final String? offical, user, avatar, name, link, tag, image, video;
  final String times, title, article, content, factCheck;

  final VoidCallback onpress;

  final bool? rate;
  const CardNews(
      {Key? key,
      required this.factCheck,
      this.offical,
      this.user,
      required this.times,
      this.image,
      this.video,
      required this.title,
      required this.article,
      this.avatar,
      this.name,
      required this.onpress,
      this.link,
      this.tag,
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
            Get.to(() => ViewNewsScreen(
                  content: widget.content,
                ));
          },
          child: Container(
            padding: EdgeInsets.all(5),
            margin: EdgeInsets.only(top: widget.tag == null ? 10 : 25),
            width: Get.size.width * 0.9,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        widget.offical != null && widget.user != null
                            ? Image.asset(
                                widget.factCheck,
                                width: 30,
                              )
                            : SizedBox(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            widget.offical != null
                                ? Row(children: [
                                    Text('Official Rating: ',
                                        style: StylesText.content12MediumBlack),
                                    Text(
                                      widget.offical!,
                                      style: StylesText.content12BoldBlack,
                                    )
                                  ])
                                : SizedBox(),
                            widget.user != null
                                ? Row(children: [
                                    widget.offical == null
                                        ? Padding(
                                            padding: const EdgeInsets.only(
                                                right: 4.0),
                                            child: Icon(
                                              FontAwesomeIcons.staylinked,
                                              size: 24,
                                              color: Colors.yellow[700],
                                            ),
                                          )
                                        : SizedBox(),
                                    Text(
                                      'Social Beliefs: ',
                                      style: StylesText.content12MediumBlack,
                                    ),
                                    Text(
                                      widget.user!,
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
                widget.image != null
                    ? Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: CachedNetworkImage(
                            fit: BoxFit.fitWidth,
                            height: 180,
                            imageUrl:
                                "${appEnvironment.apiBaseUrl}/images/news/${widget.image}",
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
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
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
                    isLoggedIn
                        ? RatingButton()
                        : InkWell(
                            onTap: () {},
                            child: Row(
                              children: [
                                Text(
                                  'Read more',
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
        // widget.tag == null
        //     ? SizedBox()
        //     : Positioned(top: 7, right: 0, child: TagTopic(tagName: widget.tag, buttonColor: Colors.blue))
      ],
    );
  }
}
