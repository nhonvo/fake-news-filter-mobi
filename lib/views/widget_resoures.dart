// ignore_for_file: prefer_const_constructors
import 'package:fake_news/languages/language_service.dart';
import 'package:fake_news/resources/utils/image.dart';
import 'package:fake_news/resources/utils/style.dart';
import 'package:fake_news/resources/widgets/button.dart';
import 'package:fake_news/resources/widgets/card.dart';
import 'package:fake_news/resources/widgets/card_news.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class WidgetResource extends StatefulWidget {
  const WidgetResource({Key? key}) : super(key: key);

  @override
  _WidgetResourceState createState() => _WidgetResourceState();
}

class _WidgetResourceState extends State<WidgetResource> {
  final language = Get.find<LanguageService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomButton(
              width: Get.size.width * 0.4,
              buttonText: 'translate',
              buttonColor: MyColors.green,
              buttonRadius: 18.5,
              textStyle: StylesText.content14BoldWhite,
              onPressed: () {
                setState(() {
                  language.updateLanguage('vi');
                });
              },
            ),
            CustomButton(
              width: Get.size.width * 0.5,
              buttonText: 'login',
              buttonColor: MyColors.blueDart,
              buttonRadius: 18.5,
              textStyle: StylesText.content14BoldWhite,
              onPressed: () {},
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomButton(
                  width: Get.size.width * 0.3,
                  height: 12.0,
                  buttonText: "f",
                  buttonColor: MyColors.blue,
                  buttonRadius: 14,
                  textStyle: StylesText.content18BoldWhite,
                  onPressed: () {},
                ),
                const SizedBox(
                  width: 10,
                ),
                CustomButton(
                  width: Get.size.width * 0.3,
                  height: 12.0,
                  buttonText: "G",
                  buttonColor: MyColors.red,
                  buttonRadius: 14,
                  textStyle: StylesText.content18BoldWhite,
                  onPressed: () {},
                ),
              ],
            ),
            CustomButton(
              width: Get.size.width * 0.4,
              buttonText: 'started',
              buttonColor: MyColors.green,
              buttonRadius: 18.5,
              textStyle: StylesText.content14BoldWhite,
              onPressed: () {},
            ),
            SizedBox(
              height: 10,
            ),
            //FIXME: ????????????????????????
            // CustomCard(),
            SizedBox(
              height: 10,
            ),
            CardNews(
                factCheck: Images.icprotect,
                offical: '50%',
                user: '56%',
                times: '7 hours',
                image: Images.chart,
                content: "",
                title:
                    '57,083 cases and 751 deaths were reported in the U.S yesterday, bringing the total to 29.5 milion cases and 536,433 deaths.',
                article: 'CNN News',
                onpress: () {})
          ],
        ),
      ),
    );
  }
}
