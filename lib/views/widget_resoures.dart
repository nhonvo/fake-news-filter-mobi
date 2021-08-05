import 'package:fake_news/languages/LocalizationService.dart';
import 'package:fake_news/resources/utils/dimension.dart';
import 'package:fake_news/resources/utils/style.dart';
import 'package:fake_news/resources/widgets/button.dart';
import 'package:fake_news/resources/widgets/card.dart';
import 'package:fake_news/resources/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class WidgetResource extends StatefulWidget {
  const WidgetResource({Key? key}) : super(key: key);

  @override
  _WidgetResourceState createState() => _WidgetResourceState();
}

class _WidgetResourceState extends State<WidgetResource> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomButton(
              width: Dimension.getWidth(0.4),
              buttonText: 'translate',
              buttonColor: MyColors.green,
              buttonRadius: 18.5,
              textStyle: StylesText.content14BoldWhite,
              onPressed: () {
                setState(() {
                  LocalizationService.changeLocale('vi');
                });
              },
            ),
            CustomButton(
              width: Dimension.getWidth(0.5),
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
                  width: Dimension.getWidth(0.3),
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
                  width: Dimension.getWidth(0.3),
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
              width: Dimension.getWidth(0.4),
              buttonText: 'started',
              buttonColor: MyColors.green,
              buttonRadius: 18.5,
              textStyle: StylesText.content14BoldWhite,
              onPressed: () {},
            ),
            SizedBox(
              height: 10,
            ),
            CustomCard(),
          ],
        ),
      ),
    );
  }
}
