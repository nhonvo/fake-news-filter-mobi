// ignore_for_file: prefer_const_constructors
import 'dart:math';

import 'package:fake_news/resources/utils/image.dart';
import 'package:fake_news/resources/utils/style.dart';
import 'package:fake_news/resources/widgets/tag.dart';
import 'package:fake_news/views/introduction/intro_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomCard extends StatefulWidget {
  CustomCard(
      {Key? key,
      required this.id,
      required this.tag,
      required this.description,
      required this.label,
      required this.noNews,
      required this.time})
      : super(key: key);

  final String id, tag, description, label, noNews, time;

  @override
  _CustomCardState createState() => _CustomCardState();
}

var colorsArr = [Colors.amber[500], Colors.pink[200], Colors.blue[400], Colors.green[400]];

class _CustomCardState extends State<CustomCard> {
  bool check = false;

  IntroViewModel get viewmodel => Get.find<IntroViewModel>();

  List<int> selectedTopicList = [];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          check = !check;
        });
        //add to selected topic list in intro viewmodel
        viewmodel.handlerGetListIdTopic(int.parse(widget.id));
      },
      child: Transform.scale(
        scale: check ? 0.95 : 1.0,
        child: Opacity(
          opacity: check ? 0.6 : 1.0,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                  width: 250,
                  height: 210,
                  decoration: BoxDecoration(
                      color: colorsArr.elementAt(new Random().nextInt(colorsArr.length)),
                      borderRadius: BorderRadius.all(Radius.circular(15.0))),
                  child: Column(
                    children: [
                      ClipRRect(
                          borderRadius:
                              BorderRadius.only(topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
                          child: Image.asset(Images.covid)),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TagTopic(
                                tagName: '#${widget.tag}',
                                buttonColor: MyColors.red.withOpacity(0.1),
                              ),
                              Text(
                                widget.description,
                                style: StylesText.content10MediumWhite,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 3,
                              ),
                              Row(
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.menu,
                                        color: Colors.white,
                                      ),
                                      Text(widget.noNews, style: StylesText.content12MediumWhite)
                                    ],
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.sync_rounded,
                                        color: Colors.white,
                                      ),
                                      Text(widget.time, style: StylesText.content12MediumWhite)
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
                  height: 25,
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
              Positioned(
                  top: -10,
                  right: -10,
                  child: Icon(
                    Icons.check_circle_rounded,
                    color: Colors.green,
                    size: check ? 35 : 0,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
