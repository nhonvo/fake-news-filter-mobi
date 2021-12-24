// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:fake_news/resources/utils/style.dart';
import 'package:fake_news/views/breaking/breaking_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'button.dart';

class RatingButton extends StatefulWidget {
  RatingButton({Key? key, required this.newsId}) : super(key: key);
  String newsId;
  int isVoted = -1;

  @override
  _RatingButtonState createState() => _RatingButtonState();
}

class _RatingButtonState extends State<RatingButton> {
  BreakingViewModel get viewmodel => Get.find<BreakingViewModel>();

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            'reliable'.tr,
            style: StylesText.content12BoldBlack,
          ),
          SizedBox(
            height: 2,
          ),
          Container(
            decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black12,
                ),
                borderRadius: BorderRadius.circular(10.0)),
            child: Row(
              children: [
                CustomIconButton(
                  buttonText: 're'.tr,
                  textStyle: StylesText.content12LightBlack,
                  onPressed: () async {
                    await viewmodel.vote(true, widget.newsId);
                    setState(() {
                      widget.isVoted = 1;
                    });
                  },
                  icon: Icon(FontAwesomeIcons.thumbsUp,
                      color: widget.isVoted == 1 ? Colors.green : Colors.black),
                  buttonColor: Colors.white,
                  buttonRadius: 10,
                ),
                CustomIconButton(
                  buttonText: 'fa'.tr,
                  textStyle: StylesText.content12LightBlack,
                  onPressed: () async {
                    await viewmodel.vote(false, widget.newsId);
                    setState(() {
                      widget.isVoted = 0;
                    });
                  },
                  icon: Icon(FontAwesomeIcons.thumbsDown,
                      color: widget.isVoted == 0 ? Colors.red : Colors.black),
                  buttonColor: Colors.white,
                  buttonRadius: 10,
                ),
              ],
            ),
          )
        ]));
  }
}
