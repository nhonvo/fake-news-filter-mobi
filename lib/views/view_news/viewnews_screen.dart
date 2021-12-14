// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, avoid_unnecessary_containers

import 'package:fake_news/resources/utils/image.dart';
import 'package:fake_news/resources/utils/style.dart';
import 'package:fake_news/resources/widgets/rating.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:html/dom.dart' as dom;
import 'package:url_launcher/url_launcher.dart';

class ViewNewsScreen extends StatefulWidget {
  final String content;

  const ViewNewsScreen({Key? key, required this.content}) : super(key: key);

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
          PopupMenuButton(
              offset: Offset(0, 50),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15.0))),
              itemBuilder: (context) => [
                    PopupMenuItem(
                      onTap: () {
                        Clipboard.setData(ClipboardData(text: widget.content)).then((_) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(content: Text('clipboard'.tr), backgroundColor: Colors.green));
                        });
                      },
                      child: Row(
                        children: [
                          Icon(FontAwesomeIcons.link, color: Colors.black, size: 17),
                          SizedBox(width: 10),
                          Text(
                            'copy'.tr,
                            style: StylesText.content14MediumBlack,
                          )
                        ],
                      ),
                      value: 1,
                    ),
                    PopupMenuItem(
                      onTap: () async {
                        // await canLaunch(widget.content)
                        //     ? await launch(widget.content)
                        //     : ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('error_browser'.tr)));
                      },
                      child: Row(
                        children: [
                          Icon(FontAwesomeIcons.globeAsia, color: Colors.black, size: 17),
                          SizedBox(width: 10),
                          Text(
                            'browser'.tr,
                            style: StylesText.content14MediumBlack,
                          )
                        ],
                      ),
                      value: 2,
                    )
                  ])
        ],
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          SingleChildScrollView(
            child: Html(
                data: widget.content,
                style: {
                  "table": Style(
                    backgroundColor: Color.fromARGB(0x50, 0xee, 0xee, 0xee),
                  ),
                  // some other granular customizations are also possible
                  "tr": Style(
                    border: Border(bottom: BorderSide(color: Colors.grey)),
                  ),
                  "th": Style(
                    padding: EdgeInsets.all(6),
                    backgroundColor: Colors.grey,
                  ),
                  "blockquote": Style(
                    backgroundColor: Colors.grey[200],
                    fontSize: FontSize(SizeText.size13),
                    color: Colors.grey[800],
                  ),
                  "p": Style(
                    padding: EdgeInsets.only(right: 10, left: 10),
                    fontSize: FontSize(SizeText.size20),
                  ),
                  // text that renders h1 elements will be red
                  "h1": Style(color: Colors.red),
                },
                onLinkTap:
                    (String? url, RenderContext context, Map<String, String> attributes, dom.Element? element) async {
                  if (await canLaunch(url.toString())) {
                    await launch(url.toString());
                  }
                  //  else {
                  //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('error_browser'.tr)));
                  // }
                }),
          ),
          //     IndexedStack(
          //       index: _stackToView,
          //       children: [
          //         Html(
          //           data: """
          //         ),
          Container(
              // child: Center(child: CupertinoActivityIndicator()),
              ),
          //       ],
          //     ),
          Positioned(
            bottom: 15,
            child: Container(
                padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                width: Get.size.width * 0.97,
                height: 90,
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
                    RatingButton(
                      newsId: "",
                    ),
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
