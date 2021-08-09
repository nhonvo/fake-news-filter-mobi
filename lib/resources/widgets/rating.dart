// ignore_for_file: prefer_const_constructors

import 'package:fake_news/resources/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

import 'button.dart';

class RatingButton extends StatefulWidget {
  const RatingButton({Key? key}) : super(key: key);

  @override
  _RatingButtonState createState() => _RatingButtonState();
}

class _RatingButtonState extends State<RatingButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        child: Column(children: [
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
                  onPressed: () {
                    print("Real");
                  },
                  icon: Icon(FontAwesomeIcons.thumbsUp, color: Colors.black),
                  buttonColor: Colors.white,
                  buttonRadius: 10,
                ),
                CustomIconButton(
                  buttonText: 'fa'.tr,
                  textStyle: StylesText.content12LightBlack,
                  onPressed: () {
                    print("Fake");
                  },
                  icon: Icon(FontAwesomeIcons.thumbsDown, color: Colors.black),
                  buttonColor: Colors.white,
                  buttonRadius: 10,
                ),
              ],
            ),
          )
        ]));
  }
}
