import 'package:fake_news/resources/utils/dimension.dart';
import 'package:fake_news/resources/utils/image.dart';
import 'package:fake_news/resources/utils/style.dart';
import 'package:fake_news/resources/widgets/button.dart';
import 'package:fake_news/resources/widgets/card.dart';
import 'package:fake_news/resources/widgets/card_topic.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class IntroductionScreen extends StatefulWidget {
  const IntroductionScreen({Key? key}) : super(key: key);

  @override
  _IntroductionScreenState createState() => _IntroductionScreenState();
}

class _IntroductionScreenState extends State<IntroductionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: 45),
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
            Colors.blue,
            Colors.white,
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
        ),
        child: Stack(
          children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      Images.logo,
                      width: Dimension.getWidth(0.20),
                    ),
                    Text("Fake News Filter",
                        style: StylesText.content18BoldWhite)
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    'introduction'.tr,
                    style: StylesText.content16BoldWhite,
                    textAlign: TextAlign.center,
                  ),
                ),
                CustomButton(
                  width: Dimension.getWidth(0.4),
                  buttonText: 'started',
                  buttonColor: MyColors.green,
                  buttonRadius: 18.5,
                  textStyle: StylesText.content14BoldWhite,
                  onPressed: () {},
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'covering'.tr,
                  style: StylesText.content14BoldWhite,
                ),
                Expanded(
                  child: GridView.count(
                    //shrinkWrap: true,
                    crossAxisCount: 2,
                    children: List.generate(10, (index) {
                      return Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: CardTopic(),
                      );
                    }),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
