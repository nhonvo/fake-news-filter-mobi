// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fake_news/resources/utils/app_config.dart';
import 'package:fake_news/resources/utils/style.dart';
import 'package:fake_news/resources/widgets/tag.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CardTopic extends StatefulWidget {
  CardTopic(
      {Key? key,
      required this.ontap,
      required this.tag,
      required this.description,
      required this.label,
      required this.noNews,
      required this.time,
      required this.image,
      required this.index})
      : super(key: key);

  final VoidCallback ontap;
  final String index, tag, description, label, noNews, image, time;
  @override
  _CardTopicState createState() => _CardTopicState();
}

class _CardTopicState extends State<CardTopic> {
  var appEnvironment = Get.find<AppEnvironment>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.ontap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
              width: 250,
              decoration: BoxDecoration(
                  color: MyColors.colorsArr.elementAt(int.parse(widget.index) % MyColors.colorsArr.length),
                  borderRadius: BorderRadius.all(Radius.circular(15.0))),
              child: Column(
                children: [
                  widget.image != "null"
                      ? ClipRRect(
                          borderRadius:
                              BorderRadius.only(topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
                          child: CachedNetworkImage(
                            fit: BoxFit.fitWidth,
                            height: 55,
                            imageUrl: widget.image,
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
                          ))
                      : Container(),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TagTopic(
                            tagName: '#${widget.tag}',
                            buttonColor: MyColors.red.withOpacity(0.2),
                          ),
                          Text(
                            widget.description,
                            style: StylesText.content10MediumWhite,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.menu,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 3,
                                  ),
                                  Text(widget.noNews, style: StylesText.content10MediumWhite)
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.sync_rounded,
                                    color: Colors.white,
                                  ),
                                  SizedBox(width: 3),
                                  Text(widget.time, style: StylesText.content10MediumWhite)
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              )),
          Positioned(
            top: -10,
            left: -10,
            child: Container(
              width: 80,
              height: 30,
              decoration: BoxDecoration(
                  color: widget.label == "featured"
                      ? MyColors.orange
                      : widget.label == "breaking"
                          ? MyColors.red
                          : Colors.transparent,
                  borderRadius: BorderRadius.all(Radius.circular(13.0))),
              child: Row(
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  widget.label == "featured"
                      ? Icon(
                          Icons.star_rounded,
                          color: Colors.white,
                        )
                      : widget.label == "breaking"
                          ? Icon(
                              Icons.psychology_sharp,
                              color: Colors.white,
                            )
                          : Container(),
                  widget.label == "featured"
                      ? Text(widget.label, style: StylesText.content12BoldWhite)
                      : widget.label == "breaking"
                          ? Text(widget.label, style: StylesText.content12BoldWhite)
                          : Container(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
