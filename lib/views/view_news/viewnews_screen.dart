import 'dart:async';
import 'dart:io';
import 'package:comment_tree/data/comment.dart';
import 'package:comment_tree/widgets/comment_tree_widget.dart';
import 'package:comment_tree/widgets/tree_theme_data.dart';
import 'package:fake_news/data/story_data.dart';
import 'package:fake_news/resources/utils/style.dart';
import 'package:fake_news/resources/widgets/rating.dart';
import 'package:fake_news/views/view_news/viewnews_viewmodel.dart';
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
  ViewNewsViewModel get viewModel => Get.find<ViewNewsViewModel>();

  final GlobalKey webViewKey = GlobalKey();

  InAppWebViewController? webViewController;

  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(
        useShouldOverrideUrlLoading: true,
        mediaPlaybackRequiresUserGesture: false,
      ),
      android: AndroidInAppWebViewOptions(useHybridComposition: true),
      ios: IOSInAppWebViewOptions(
        allowsInlineMediaPlayback: true,
      ));

  late PullToRefreshController pullToRefreshController;
  double progress = 0;
  final urlController = TextEditingController();
  bool isRoute = false;
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
          webViewController?.loadUrl(urlRequest: URLRequest(url: await webViewController?.getUrl()));
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
              backgroundColor: Colors.white, foregroundColor: Colors.black //here you can give the text color
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
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15.0))),
                itemBuilder: (context) => [
                      PopupMenuItem(
                        onTap: () {
                          Clipboard.setData(ClipboardData(text: widget.webUrl)).then((_) {
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
                          await canLaunchUrl(Uri.parse(widget.webUrl!))
                              ? await launchUrl(
                                  Uri.parse(widget.webUrl!),
                                  mode: LaunchMode.externalApplication,
                                )
                              : ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('error_browser'.tr)));
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
                      ),
                      PopupMenuItem(
                        onTap: () async {},
                        child: Row(
                          children: [
                            Icon(FontAwesomeIcons.flagCheckered, color: Colors.black, size: 17),
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
              onLoadStop: (controller, url) async {
                pullToRefreshController.endRefreshing();
              },
              onLoadError: (controller, url, code, message) {
                pullToRefreshController.endRefreshing();
              },
              onPageCommitVisible: (con, uri) {
                if (GetPlatform.isIOS) con.goBack();
              },
              onProgressChanged: (controller, progress) {
                if (progress == 100) {
                  pullToRefreshController.endRefreshing();
                  isRoute = true;
                }
                setState(() {
                  this.progress = progress / 100;
                });
              },
              shouldOverrideUrlLoading: (controller, navigationAction) async {
                if (GetPlatform.isAndroid) {
                  if (isRoute == true) {
                    return NavigationActionPolicy.CANCEL;
                  }
                  return NavigationActionPolicy.ALLOW;
                }
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
                  child: LinearProgressIndicator(color: Colors.black, backgroundColor: Colors.white, value: progress),
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
                          _commentButton(widget.newsId),
                          VerticalDivider(),
                          Icon(FontAwesomeIcons.shareAlt),
                          VerticalDivider(),
                          Icon(FontAwesomeIcons.bookmark),
                        ]
                      : [
                          Container(),
                          _commentButton(widget.newsId),
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

  Widget _commentButton(String newsId) {
    return InkWell(
      onTap: () {
        viewModel.isLoading.value = true;
        viewModel.getCommentInNews(newsId);

//reset value every time bottom show
        if (Get.isBottomSheetOpen == false) {
          viewModel.commentId.value = "";
        }

        Get.bottomSheet(
          Container(
            height: Get.height * 1,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Obx(
              () => viewModel.isLoading.value == false
                  ? Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          width: 50,
                          height: 5,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Obx(
                                  () => viewModel.comList.isNotEmpty
                                      ? ListView.builder(
                                          shrinkWrap: true,
                                          physics: NeverScrollableScrollPhysics(),
                                          itemCount: viewModel.comList.length,
                                          itemBuilder: (context, index) {
                                            return Container(
                                              child: CommentTreeWidget<Comment, Comment>(
                                                Comment(
                                                  commentId: viewModel.comList[index].commentId.toString(),
                                                  avatar: 'null',
                                                  userName: viewModel.comList[index].user?.userName ?? "Anonymous",
                                                  content: viewModel.comList[index].content,
                                                ),
                                                [
                                                  //render recursive reply comment
                                                  if (viewModel.comList[index].child != null)
                                                    for (var item in viewModel.comList[index].child!)
                                                      Comment(
                                                        commentId: item.commentId.toString(),
                                                        avatar: 'null',
                                                        userName: item.user?.userName ?? "Anonymous",
                                                        content: item.content,
                                                      ),
                                                ],
                                                treeThemeData: TreeThemeData(
                                                  lineColor: viewModel.comList[index].child!.length > 0
                                                      ? Colors.green[600]!
                                                      : Colors.transparent,
                                                  lineWidth: 1.4,
                                                ),
                                                avatarRoot: (context, data) => PreferredSize(
                                                  child: CircleAvatar(
                                                    radius: 18,
                                                    backgroundColor: Colors.grey,
                                                    backgroundImage: AssetImage('assets/images/avatar.png'),
                                                  ),
                                                  preferredSize: Size.fromRadius(18),
                                                ),
                                                contentRoot: (context, data) {
                                                  return Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Container(
                                                        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                                                        decoration: BoxDecoration(
                                                          color: Colors.grey[100],
                                                          borderRadius: BorderRadius.circular(12),
                                                        ),
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Text(
                                                              data.userName ?? "Anonymous",
                                                              style: Theme.of(context).textTheme.caption!.copyWith(
                                                                  fontWeight: FontWeight.w600, color: Colors.black),
                                                            ),
                                                            SizedBox(
                                                              height: 4,
                                                            ),
                                                            Text(
                                                              '${data.content}',
                                                              style: Theme.of(context).textTheme.caption!.copyWith(
                                                                  fontWeight: FontWeight.w300, color: Colors.black),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      DefaultTextStyle(
                                                        style: Theme.of(context).textTheme.caption!.copyWith(
                                                            color: Colors.grey[700], fontWeight: FontWeight.bold),
                                                        child: Padding(
                                                          padding: EdgeInsets.only(top: 4),
                                                          child: Row(
                                                            children: [
                                                              // SizedBox(
                                                              //   width: 8,
                                                              // ),
                                                              // Text('Like'),
                                                              // SizedBox(
                                                              //   width: 24,
                                                              // ),
                                                              //show reply text field
                                                              if (widget.isLoggedIn == true)
                                                                InkWell(
                                                                  onTap: () {
                                                                    viewModel.commentId.value = data.commentId;
                                                                  },
                                                                  //change color when click
                                                                  child: Obx(
                                                                    () => viewModel.commentId.value == data.commentId
                                                                        ? Text(
                                                                            'Reply',
                                                                            style: TextStyle(
                                                                              fontWeight: FontWeight.bold,
                                                                              color: Colors.green[600],
                                                                            ),
                                                                          )
                                                                        : Text(
                                                                            'Reply',
                                                                            style: TextStyle(
                                                                              color: Colors.grey[700],
                                                                            ),
                                                                          ),
                                                                  ),
                                                                ),
                                                            ],
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  );
                                                },
                                                avatarChild: (context, data) => PreferredSize(
                                                  child: CircleAvatar(
                                                    radius: 12,
                                                    backgroundColor: Colors.grey,
                                                    backgroundImage: AssetImage('assets/images/avatar.png'),
                                                  ),
                                                  preferredSize: Size.fromRadius(12),
                                                ),
                                                contentChild: (context, data) {
                                                  return Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Container(
                                                        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                                                        decoration: BoxDecoration(
                                                            color: Colors.grey[100],
                                                            borderRadius: BorderRadius.circular(12)),
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Text(
                                                              data.userName ?? "Anonymous",
                                                              style: Theme.of(context).textTheme.caption?.copyWith(
                                                                  fontWeight: FontWeight.w600, color: Colors.black),
                                                            ),
                                                            SizedBox(
                                                              height: 4,
                                                            ),
                                                            Text(
                                                              '${data.content}',
                                                              style: Theme.of(context).textTheme.caption?.copyWith(
                                                                  fontWeight: FontWeight.w300, color: Colors.black),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      DefaultTextStyle(
                                                        style: Theme.of(context).textTheme.caption!.copyWith(
                                                            color: Colors.grey[700], fontWeight: FontWeight.bold),
                                                        child: Padding(
                                                          padding: EdgeInsets.only(top: 4),
                                                          child: Row(
                                                            children: [
                                                              // SizedBox(
                                                              //   width: 8,
                                                              // ),
                                                              // Text('Like'),
                                                              // SizedBox(
                                                              //   width: 24,
                                                              // ),
                                                              // Text('Reply'),
                                                            ],
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  );
                                                },
                                              ),
                                              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                                            );
                                          },
                                        )
                                      : Container(
                                          //get height bottom sheet,
                                          height: MediaQuery.of(context).size.height * 0.5,
                                          child: Center(
                                            child: Text(
                                              'No comments yet',
                                              style: TextStyle(
                                                color: Colors.grey[700],
                                              ),
                                            ),
                                          ),
                                        ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        //text field to input comment

                        if (widget.isLoggedIn == true)
                          Expanded(
                            flex: 1,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    radius: 18,
                                    backgroundColor: Colors.grey,
                                    backgroundImage: AssetImage('assets/images/avatar.png'),
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),

                                  Expanded(
                                    child: TextField(
                                      controller: viewModel.textCommentController,
                                      decoration: InputDecoration(
                                        focusedBorder: OutlineInputBorder(
                                          gapPadding: 1,
                                          borderSide: BorderSide(color: Colors.black, width: 1),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          gapPadding: 1,
                                          borderSide: BorderSide(color: Colors.grey, width: .5),
                                        ),
                                        hintText: 'Add a comment...',
                                      ),
                                    ),
                                  ),
                                  //send button
                                  InkWell(
                                    onTap: () {
                                      viewModel.addComment(newsId);
                                    },
                                    child: Text(
                                      'Post',
                                      style: Theme.of(context).textTheme.caption,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                      ],
                    )
                  : Center(
                      child: CircularProgressIndicator(),
                    ),
            ),
          ),
        );
      },
      child: Row(
        children: [
          Icon(
            FontAwesomeIcons.comment,
            color: Colors.black,
          ),
          SizedBox(width: 5),
        ],
      ),
    );
  }
}
