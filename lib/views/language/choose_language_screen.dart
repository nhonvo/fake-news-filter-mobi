import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fake_news/resources/utils/app_constant.dart';
import 'package:fake_news/resources/utils/app_routes.dart';
import 'package:fake_news/resources/utils/icon.dart';
import 'package:fake_news/resources/utils/style.dart';
import 'package:fake_news/resources/widgets/button.dart';
import 'package:fake_news/views/discovery/discovery_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class ChooseLanguageScreen extends StatefulWidget {
  const ChooseLanguageScreen({Key? key}) : super(key: key);

  @override
  _ChooseLanguageScreenState createState() => _ChooseLanguageScreenState();
}

class _ChooseLanguageScreenState extends State<ChooseLanguageScreen> {
  DiscoveryViewModel get viewmodel => Get.find<DiscoveryViewModel>();

  Widget iconBuilder(int i, Size size, bool active) {
    SvgPicture data = SvgPicture.asset(
      IconsApp.en,
    );

    if (i.isEven) data = SvgPicture.asset(IconsApp.vi);

    return data;
  }

  @override
  Widget build(BuildContext context) {
    int defaultLanguage =
        viewmodel.languageService.currentLanguage == "en" ? 1 : 0;

    //get the current language from the language service
    if (viewmodel.getLanguageContent.value != "") {
      viewmodel.selectedValue.value = viewmodel.languagesList?.indexWhere(
              (element) => element.id == viewmodel.getLanguageContent.value) ??
          0;
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
                  indicatorAnimationType: AnimationType.onSelected,
                  current: defaultLanguage,
                  values: [0, 1],
                  onChanged: (i) {
                    defaultLanguage = i;
                    viewmodel.handleChangeLanguage();
                  },
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
                        itemCount: viewmodel.languagesList?.length ?? 0,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              viewmodel.selectedValue.value = index;
                              viewmodel.getLanguageContent.value =
                                  viewmodel.languagesList?[index].id ?? 'en';
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                              child: Container(
                                width: 175,
                                padding: EdgeInsets.all(25),
                                child: Obx(
                                  () => Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      viewmodel.languagesList?[index].flag !=
                                              null
                                          ? CachedNetworkImage(
                                              width: 50,
                                              height: 50,
                                              imageUrl:
                                                  "${viewmodel.appEnvironment.apiBaseUrl}/images/languages/${viewmodel.languagesList?[index].flag}",
                                              imageBuilder:
                                                  (context, imageProvider) =>
                                                      Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(6),
                                                  image: DecorationImage(
                                                      image: imageProvider,
                                                      fit: BoxFit.fitWidth,
                                                      colorFilter:
                                                          ColorFilter.mode(
                                                              Colors.red,
                                                              BlendMode
                                                                  .colorBurn)),
                                                ),
                                              ),
                                              placeholder: (context, url) =>
                                                  CupertinoActivityIndicator(),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Icon(Icons.error),
                                            )
                                          : Container(),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                              viewmodel
                                                  .languagesList![index].name
                                                  .toString(),
                                              style: viewmodel.selectedValue
                                                          .value ==
                                                      index
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
                                                color: viewmodel.selectedValue
                                                            .value ==
                                                        index
                                                    ? MyColors.blue
                                                    : Colors.black12),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
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
                onPressed: () async {
                  //save language content to shared pref
                  viewmodel.prefs.setString(
                      AppConstant.sharePrefKeys.languageContent,
                      viewmodel.getLanguageContent.value);

                  await OneSignal.shared.sendTag(
                      "language_content", viewmodel.getLanguageContent.value);

                  //only fetching topic data when user choose language in discovery screen and follow topic screen
                  if (viewmodel.getLanguageContent.value !=
                          viewmodel.tempLanguageContent.value &&
                      (Get.currentRoute == Routes.DISCOVERY ||
                          Get.currentRoute == Routes.FOLLOW_TOPIC)) {
                    viewmodel.handleGetTopic();
                    //saving selected language content to temporary variable for compare with new language content
                    viewmodel.tempLanguageContent.value =
                        viewmodel.getLanguageContent.value;
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
