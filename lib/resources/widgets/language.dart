import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:fake_news/languages/language_service.dart';
import 'package:fake_news/resources/utils/image.dart';
import 'package:fake_news/resources/utils/style.dart';
import 'package:fake_news/resources/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class ChooseLanguage extends StatefulWidget {
  const ChooseLanguage({Key? key}) : super(key: key);

  @override
  _ChooseLanguageState createState() => _ChooseLanguageState();
}

class _ChooseLanguageState extends State<ChooseLanguage> {
  int selectedValue = 0;

  final language = Get.find<LanguageService>();

  Widget iconBuilder(int i, Size size, bool active) {
    SvgPicture data = SvgPicture.asset(
      Images.en,
    );

    if (i.isEven) data = SvgPicture.asset(Images.vi);

    return data;
  }

  @override
  Widget build(BuildContext context) {
    int defaultlanguage = language.currentLanguage == "en" ? 1 : 0;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          InkWell(
            onTap: () {
              Get.back();
            },
            child: const Icon(
              Icons.cancel,
              color: Colors.blue,
            ),
          ),
          Center(
              child: Text(
            'LANGUAGE MANAGERMENT',
            style: StylesText.content17BoldBlue,
          )),
          const SizedBox(
            height: 10,
          ),
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Select your display language",
                  style: StylesText.content14BoldBlack,
                ),
                SizedBox(
                  height: 10,
                ),
                AnimatedToggleSwitch<int>.rolling(
                  borderWidth: 1,
                  indicatorColor: Colors.white12,
                  borderColor: Colors.white,
                  innerColor: Colors.white,
                  iconOpacity: 0.2,
                  indicatorSize: Size.fromWidth(80),
                  indicatorType: IndicatorType.rectangle,
                  current: defaultlanguage,
                  values: [0, 1],
                  onChanged: (i) => setState(() {
                    defaultlanguage = i;
                    if (language.currentLanguage == "en") {
                      language.updateLanguage("vi");
                    } else {
                      language.updateLanguage("en");
                    }
                  }),
                  iconBuilder: iconBuilder,
                  height: 55,
                  dif: 10,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "What language do you want to read news?",
                  style: StylesText.content14BoldBlack,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                    height: 150,
                    child: ListView.builder(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        scrollDirection: Axis.horizontal,
                        physics: BouncingScrollPhysics(),
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedValue = index;
                              });
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                              child: Container(
                                width: 175,
                                padding: EdgeInsets.all(25),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(6),
                                        image: DecorationImage(
                                            image: AssetImage(Images.logo)),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("English",
                                            style: selectedValue == index
                                                ? StylesText.content14BoldBlue
                                                : StylesText
                                                    .content14MediumBlack),
                                        Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              border: Border.all(
                                                  color: Colors.black12)),
                                          child: Icon(Icons.check,
                                              size: 18,
                                              color: selectedValue == index
                                                  ? MyColors.blue
                                                  : Colors.black12),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        }))
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Center(
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: CustomButton(
                buttonText: 'Đồng ý',
                width: Get.size.width * 0.8,
                onPressed: () {
                  Navigator.pop(context);
                },
                buttonRadius: 20,
                buttonColor: MyColors.blue,
                textStyle: StylesText.content14MediumWhite,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
