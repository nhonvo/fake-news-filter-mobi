// ignore_for_file: prefer_const_constructors, non_constant_identifier_names

import 'package:fake_news/resources/utils/dimension.dart';
import 'package:fake_news/resources/utils/image.dart';
import 'package:fake_news/resources/utils/style.dart';
import 'package:fake_news/resources/widgets/button.dart';
import 'package:fake_news/resources/widgets/rating.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ViewNewsScreen extends StatefulWidget {
  final String url_news;

  const ViewNewsScreen({Key? key, required this.url_news}) : super(key: key);

  @override
  _ViewNewsScreenState createState() => _ViewNewsScreenState();
}

class _ViewNewsScreenState extends State<ViewNewsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              Images.logo,
              width: 30,
            ),
            const SizedBox(width: 10),
            Text('appname'.tr, style: StylesText.content16BoldWhite)
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {},
          )
        ],
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          WebView(
            initialUrl: widget.url_news,
          ),
          Positioned(
            bottom: 15,
            child: Container(
                padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                width: Dimension.getWidth(0.97),
                height: Dimension.getHeight(0.12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                  // ignore: prefer_const_literals_to_create_immutables
                  boxShadow: [
                    BoxShadow(
                        color: Color.fromRGBO(123, 174, 255, 0.5),
                        blurRadius: 2.0,
                        spreadRadius: 2.0,
                        offset: Offset(
                          1.0,
                          1.0,
                        ))
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    RatingButton(),
                    VerticalDivider(),
                    Icon(FontAwesomeIcons.comments),
                    VerticalDivider(),
                    Icon(FontAwesomeIcons.shareAlt),
                    VerticalDivider(),
                    Icon(FontAwesomeIcons.bookmark),
                  ],
                )),
          )
        ],
      ),
    );
  }
}
