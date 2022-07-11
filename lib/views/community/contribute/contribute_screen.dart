import 'package:fake_news/resources/utils/style.dart';
import 'package:fake_news/resources/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';

class ContributeScreen extends StatefulWidget {
  const ContributeScreen({Key? key}) : super(key: key);

  @override
  _ContributeScreenState createState() => _ContributeScreenState();
}

class _ContributeScreenState extends State<ContributeScreen> {
  final FocusNode inputNode = FocusNode();
  final TextEditingController _controller = TextEditingController();

  List<Asset> images = <Asset>[];

  Widget buildGridView() {
    return Container(
      height: 100,
      child: GridView.count(
        crossAxisSpacing: 10,
        scrollDirection: Axis.vertical,
        crossAxisCount: 5,
        children: List.generate(images.length, (index) {
          Asset asset = images[index];
          return AssetThumb(
            asset: asset,
            width: 150,
            height: 150,
          );
        }),
      ),
    );
  }

  Future<void> loadAssets() async {
    List<Asset> resultList = <Asset>[];

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 300,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(
          takePhotoIcon: "chat",
          doneButtonTitle: "OKAY",
        ),
        materialOptions: MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle: "Example App",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
    } on Exception {}

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      images = resultList;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      inputNode.requestFocus();
    });
  }

  @override
  Widget build(BuildContext context) {
    FocusScope.of(context).requestFocus(inputNode);
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [Text('appname'.tr, style: StylesText.content16BoldWhite)],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.info_outline_rounded),
            onPressed: () {},
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            bottom: 10,
            left: 10,
            right: 10,
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  images != null ? buildGridView() : Container(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: loadAssets,
                        child: Row(
                          children: [
                            Icon(
                              Icons.backup_outlined,
                              color: Colors.blue,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "Thêm tệp đính kèm",
                              style: StylesText.content12MediumBlack,
                            )
                          ],
                        ),
                      ),
                      CustomButton(
                        width: 70,
                        buttonText: 'Gửi',
                        buttonColor: MyColors.blue,
                        buttonRadius: 10,
                        textStyle: StylesText.content16BoldWhite,
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                TextFormField(
                  controller: _controller,
                  focusNode: inputNode,
                  autofocus: true,
                  keyboardType: TextInputType.multiline,
                  maxLines: 2,
                  decoration: InputDecoration(
                    hintStyle: StylesText.content14LightBlack,
                    hintText: "Tiêu đề",
                    fillColor: Colors.white,
                  ),
                ),
                TextFormField(
                  minLines: 7,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: InputDecoration(
                    hintStyle: StylesText.content14LightBlack,
                    hintText: "Nội dung",
                    fillColor: Colors.white,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
