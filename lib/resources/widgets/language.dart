import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fake_news/languages/language_service.dart';
import 'package:fake_news/models/language_model.dart';
import 'package:fake_news/resources/utils/app_config.dart';
import 'package:fake_news/resources/utils/app_constant.dart';
import 'package:fake_news/resources/utils/icon.dart';
import 'package:fake_news/resources/utils/style.dart';
import 'package:fake_news/resources/widgets/button.dart';
import 'package:fake_news/views/discovery/discovery_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChooseLanguage extends StatefulWidget {
  const ChooseLanguage({Key? key}) : super(key: key);

  @override
  _ChooseLanguageState createState() => _ChooseLanguageState();
}

class _ChooseLanguageState extends State<ChooseLanguage> {
  int? selectedValue = 0;
  String? getLanguageContent, tempLanguage;

  SharedPreferences _prefs = Get.find<SharedPreferences>();
  final language = Get.find<LanguageService>();
  var languagesList = Get.find<List<LanguageModel>?>();
  var appEnvironment = Get.find<AppEnvironment>();

  DiscoveryViewModel get viewmodel => Get.find<DiscoveryViewModel>();

  @override
  void initState() {
    super.initState();
    getLanguageContent = _prefs.getString(AppConstant.sharePrefKeys.languageContent) ?? "";
    tempLanguage = getLanguageContent;
  }

  Widget iconBuilder(int i, Size size, bool active) {
    SvgPicture data = SvgPicture.asset(
      IconsApp.en,
    );

    if (i.isEven) data = SvgPicture.asset(IconsApp.vi);

    return data;
  }

  @override
  Widget build(BuildContext context) {
    int defaultLanguage = language.currentLanguage == "en" ? 1 : 0;

    if (getLanguageContent != "") {
      selectedValue = languagesList?.indexWhere((element) => element.id == getLanguageContent);
    }

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
            'managelanguage'.tr,
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
                  'displaylanguage'.tr,
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
                  current: defaultLanguage,
                  values: [0, 1],
                  onChanged: (i) => setState(() {
                    defaultLanguage = i;
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
                  'contentlanguage'.tr,
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
                        itemCount: languagesList?.length ?? 0,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedValue = index;
                                getLanguageContent = languagesList?[index].id;
                              });
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              child: Container(
                                width: 175,
                                padding: EdgeInsets.all(25),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    CachedNetworkImage(
                                      width: 50,
                                      height: 50,
                                      imageUrl:
                                          "${appEnvironment.apiBaseUrl}/images/languages/${languagesList?[index].flag}",
                                      imageBuilder: (context, imageProvider) => Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(6),
                                          image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.fitWidth,
                                              colorFilter: ColorFilter.mode(Colors.red, BlendMode.colorBurn)),
                                        ),
                                      ),
                                      placeholder: (context, url) => CupertinoActivityIndicator(),
                                      errorWidget: (context, url, error) => Icon(Icons.error),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(languagesList![index].name.toString(),
                                            style: selectedValue == index
                                                ? StylesText.content14BoldBlue
                                                : StylesText.content14MediumBlack),
                                        Container(
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(100),
                                              border: Border.all(color: Colors.black12)),
                                          child: Icon(Icons.check,
                                              size: 18, color: selectedValue == index ? MyColors.blue : Colors.black12),
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
                buttonText: 'okay'.tr,
                width: Get.size.width * 0.8,
                onPressed: () {
                  //save language content to shared pref
                  _prefs.setString(AppConstant.sharePrefKeys.languageContent, getLanguageContent.toString());

                  if (getLanguageContent != tempLanguage) {
                    viewmodel.handleGetTopic();
                  }

                  Get.back();
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
