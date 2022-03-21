import 'package:fake_news/resources/utils/icon.dart';
import 'package:fake_news/resources/utils/style.dart';
import 'package:fake_news/resources/widgets/avatar.dart';
import 'package:fake_news/resources/widgets/button.dart';
import 'package:fake_news/views/comming_soon_screen.dart';
import 'package:fake_news/views/follow_topic/follow_topic.dart';
import 'package:fake_news/views/language/choose_language_screen.dart';
import 'package:fake_news/views/profile_setting/profile_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ProfileViewModel get viewModel => Get.find<ProfileViewModel>();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(top: 10, left: 15, right: 15),
          child: SingleChildScrollView(
            padding: EdgeInsets.only(top: 5, bottom: 5),
            child: Column(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    _buildInfoHeader(),
                    SizedBox(
                      height: 40,
                    ),
                    Text(
                      'config'.tr,
                      style: StylesText.content16BoldBlack,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    _infoConfig(context),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'aboutFnf'.tr,
                      style: StylesText.content16BoldBlack,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    _infoSupport(context)
                  ],
                ),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            margin: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
            child: Text(
              'version'.tr,
              style: StylesText.content12LightBlack,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCicleAvatar(String url) {
    return CircleAvatarCustom(
      radius: 40,
      url: url,
    );
  }

  Widget _buildInfoHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _buildCicleAvatar(
                "https://scontent.fsgn8-1.fna.fbcdn.net/v/t1.6435-9/182394264_2883716055249217_2405969830174331902_n.jpg?_nc_cat=105&ccb=1-5&_nc_sid=09cbfe&_nc_ohc=s25Yo5XumrwAX9T_BHX&_nc_ht=scontent.fsgn8-1.fna&oh=00_AT_aIE7OYqlx7QjRyp9cpgn5-hkQsyKP7MvB_pffvdhpLQ&oe=61E268EF"),
            Container(
              margin: EdgeInsets.only(left: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Huynh Huu Khanh',
                    style: StylesText.content18BoldBlack,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    child: CustomButton(
                        buttonText: 'updateProfile'.tr,
                        onPressed: () {},
                        width: 200,
                        buttonRadius: 20,
                        buttonColor: Colors.white,
                        textStyle: StylesText.content12MediumBlack),
                  ),
                ],
              ),
            ),
          ],
        ),
        InkWell(
          child: SvgPicture.asset(IconsApp.exit, width: 30),
          onTap: () async {
            viewModel.handlelogout();
          },
        )
      ],
    );
  }

  Widget _infoConfig(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(top: 5, bottom: 5),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 1.0,
              ),
            ],
          ),
          child: Column(
            children: <Widget>[
              BuildItemButon(
                  icon: IconsApp.language,
                  content: 'klanguage'.tr,
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return ChooseLanguageScreen();
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    );
                  }),
              BuildItemButon(
                  icon: IconsApp.follow,
                  content: 'followTopic'.tr,
                  onTap: () {
                    Get.to(FollowTopicScreen());
                  }),
              BuildItemButon(
                icon: IconsApp.social,
                content: 'linkSocial'.tr,
                //return coming soon screen when button is clicked
                onTap: () => Get.to(() => ComingSoonScreen()),
              ),
            ],
          ),
        )
      ],
    );
  }
}

Widget _infoSupport(BuildContext context) {
  return Column(
    children: <Widget>[
      Container(
        padding: EdgeInsets.only(top: 5, bottom: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 1.0,
            ),
          ],
        ),
        child: Column(
          children: <Widget>[
            BuildItemButon(
              icon: IconsApp.faq,
              content: 'FAQ',
              onTap: () => Get.to(() => ComingSoonScreen()),
            ),
            BuildItemButon(
              icon: IconsApp.rate,
              content: 'rateApp'.tr,
              onTap: () => Get.to(() => ComingSoonScreen()),
            ),
            BuildItemButon(
              icon: IconsApp.about,
              content: 'aboutFnf'.tr,
              onTap: () => Get.to(() => ComingSoonScreen()),
            ),
            BuildItemButon(
              icon: IconsApp.support,
              content: 'support'.tr,
              onTap: () => Get.to(() => ComingSoonScreen()),
            ),
          ],
        ),
      )
    ],
  );
}

class BuildItemButon extends StatelessWidget {
  final String icon;
  final String content;
  final Function onTap;
  BuildItemButon({required this.icon, required this.content, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: SvgPicture.asset(
                  icon,
                  width: 30,
                )),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                content,
                style: StylesText.content14MediumBlack,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
