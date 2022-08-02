import 'package:fake_news/resources/utils/image.dart';
import 'package:fake_news/resources/utils/style.dart';
import 'package:fake_news/resources/widgets/rating.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class ViewNewsScreen extends StatefulWidget {
  ViewNewsScreen({
    Key? key,
    required this.content,
    this.isLoggedIn,
    this.webUrl,
    required this.newsId,
  }) : super(key: key);

  final String content, newsId;
  final String? webUrl;
  late bool? isLoggedIn;

  @override
  _ViewNewsScreenState createState() => _ViewNewsScreenState();
}

class _ViewNewsScreenState extends State<ViewNewsScreen> {
  int _stackToView = 1;

  Future<String> get _url async {
    await Future.delayed(Duration(seconds: 1));
    return widget.webUrl.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
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
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0))),
              itemBuilder: (context) => [
                    PopupMenuItem(
                      onTap: () {
                        Clipboard.setData(ClipboardData(text: widget.webUrl))
                            .then((_) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('clipboard'.tr),
                              backgroundColor: Colors.green));
                        });
                      },
                      child: Row(
                        children: [
                          Icon(FontAwesomeIcons.link,
                              color: Colors.black, size: 17),
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
                        await canLaunchUrl(Uri.parse(widget.webUrl!))
                            ? await launchUrl(Uri.parse(widget.webUrl!))
                            : ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('error_browser'.tr)));
                      },
                      child: Row(
                        children: [
                          Icon(FontAwesomeIcons.globeAsia,
                              color: Colors.black, size: 17),
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
          FutureBuilder(
            future: _url,
            builder: (BuildContext context, AsyncSnapshot snapshot) =>
                snapshot.hasData
                    ? WebView(
                        initialUrl: snapshot.data,
                        navigationDelegate: (NavigationRequest request) {
                          if (request.url.compareTo(snapshot.data) != 0) {
                            //Chặn khi rời website khác
                            return NavigationDecision.prevent;
                          }
                          return NavigationDecision.navigate;
                        },
                        onPageFinished: (String url) {
                          setState(() {
                            _stackToView = 0;
                          });
                        },
                      )
                    : Container(child: LinearProgressIndicator()),
          ),
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
                children: widget.isLoggedIn == true
                    ? [
                        RatingButton(
                          newsId: widget.newsId,
                        ),
                        VerticalDivider(),
                        Icon(FontAwesomeIcons.comments),
                        VerticalDivider(),
                        Icon(FontAwesomeIcons.shareAlt),
                        VerticalDivider(),
                        Icon(FontAwesomeIcons.bookmark),
                      ]
                    : [
                        Container(),
                        Icon(FontAwesomeIcons.comments),
                        VerticalDivider(),
                        Icon(FontAwesomeIcons.shareAlt),
                        VerticalDivider(),
                        Icon(FontAwesomeIcons.bookmark),
                        Container(),
                      ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
