import 'dart:async';
import 'dart:io';
import 'package:fake_news/resources/utils/style.dart';
import 'package:fake_news/resources/widgets/rating.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class ViewNewsScreen extends StatefulWidget {
  ViewNewsScreen({
    Key? key,
    this.isLoggedIn,
    this.webUrl,
    this.publisher,
    required this.newsId,
  }) : super(key: key);

  final String newsId;
  final String? publisher;
  late final String? webUrl;
  late bool? isLoggedIn;

  @override
  _ViewNewsScreenState createState() => _ViewNewsScreenState();
}

class _ViewNewsScreenState extends State<ViewNewsScreen> {
  final GlobalKey webViewKey = GlobalKey();

  InAppWebViewController? webViewController;

  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(
        useShouldOverrideUrlLoading: true,
        mediaPlaybackRequiresUserGesture: false,
      ),
      android: AndroidInAppWebViewOptions(
        useHybridComposition: true,
      ),
      ios: IOSInAppWebViewOptions(
        allowsInlineMediaPlayback: true,
      ));

  late PullToRefreshController pullToRefreshController;
  String url = "";
  double progress = 0;
  final urlController = TextEditingController();

  @override
  void initState() {
    super.initState();
    pullToRefreshController = PullToRefreshController(
      options: PullToRefreshOptions(
        color: Colors.blue,
      ),
      onRefresh: () async {
        if (Platform.isAndroid) {
          webViewController?.reload();
        } else if (Platform.isIOS) {
          webViewController?.loadUrl(
              urlRequest: URLRequest(url: await webViewController?.getUrl()));
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryIconTheme: const IconThemeData.fallback().copyWith(
            color: Colors.black,
          ),
          appBarTheme: AppBarTheme(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black //here you can give the text color
              )),
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Get.back(),
          ),
          title: Center(
            child: Text(
              widget.publisher?.toUpperCase() ?? 'appname'.tr,
              style: StylesText.content16BoldBlack,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                webViewController?.reload();
              },
            ),
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
                              ? await launchUrl(
                                  Uri.parse(widget.webUrl!),
                                  mode: LaunchMode.externalApplication,
                                )
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
                      ),
                      PopupMenuItem(
                        onTap: () async {},
                        child: Row(
                          children: [
                            Icon(FontAwesomeIcons.flagCheckered,
                                color: Colors.black, size: 17),
                            SizedBox(width: 10),
                            Text(
                              'reportLink'.tr,
                              style: StylesText.content14MediumBlack,
                            )
                          ],
                        ),
                        value: 3,
                      )
                    ])
          ],
        ),
        body: Stack(
          alignment: Alignment.center,
          children: [
            InAppWebView(
              key: webViewKey,
              initialUrlRequest: URLRequest(url: Uri.parse(widget.webUrl!)),
              initialOptions: options,
              pullToRefreshController: pullToRefreshController,
              onWebViewCreated: (controller) {
                webViewController = controller;
              },
              androidOnPermissionRequest:
                  (controller, origin, resources) async {
                return PermissionRequestResponse(
                    resources: resources,
                    action: PermissionRequestResponseAction.GRANT);
              },
              onLoadStop: (controller, url) async {
                pullToRefreshController.endRefreshing();
              },
              onLoadError: (controller, url, code, message) {
                pullToRefreshController.endRefreshing();
              },
              onProgressChanged: (controller, progress) {
                if (progress == 100) {
                  pullToRefreshController.endRefreshing();
                }
                setState(() {
                  this.progress = progress / 100;
                  urlController.text = this.url;
                });
              },
              onPageCommitVisible: (con, uri) {
                con.goBack();
              },
              onUpdateVisitedHistory: (controller, url, androidIsReload) {
                setState(() {
                  this.url = url.toString();
                  urlController.text = this.url;
                });
              },
              onConsoleMessage: (controller, consoleMessage) {
                print(consoleMessage);
              },
            ),
            if (progress < 0.8)
              Align(
                alignment: AlignmentDirectional.topStart,
                child: SizedBox(
                  height: 1.5,
                  child: LinearProgressIndicator(
                      color: Colors.black,
                      backgroundColor: Colors.white,
                      value: progress),
                ),
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
      ),
    );
  }
}
