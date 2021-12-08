import 'package:fake_news/resources/utils/icon.dart';
import 'package:fake_news/resources/utils/style.dart';
import 'package:fake_news/resources/widgets/avatar.dart';
import 'package:fake_news/resources/widgets/button.dart';
import 'package:fake_news/resources/widgets/icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
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
                      'Thiết lập',
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
                      'Về Fake News Filter',
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
            margin:
                EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
            child: Text(
              'Phiên bản 0.0.1',
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
                "https://scontent.fdad3-4.fna.fbcdn.net/v/t1.6435-9/103099051_1406544689546058_2645542971869687953_n.jpg?_nc_cat=104&ccb=1-5&_nc_sid=09cbfe&_nc_ohc=2s9RY20WIvYAX8LubND&_nc_ht=scontent.fdad3-4.fna&oh=1903adfdb80ed6bd55fcf9b5bc962417&oe=61D79C7F"),
            Container(
              margin: EdgeInsets.only(left: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Bui Phu Khuyen',
                    style: StylesText.content18BoldBlack,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    child: CustomButton(
                        buttonText: 'Cập nhật thông tin cá nhân',
                        onPressed: () {},
                        width: 200,
                        buttonRadius: 20,
                        buttonColor: Colors.white,
                        textStyle: StylesText.content12BoldBlack),
                  ),
                ],
              ),
            ),
          ],
        ),
        IconButton(
          icon: Icon(Icons.exit_to_app),
          onPressed: () async {
            //Logout
          },
        ),
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
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black38,
                blurRadius: 1.0,
              ),
            ],
          ),
          child: Column(
            children: <Widget>[
              BuildItemButon(
                colorbrg: Colors.blue,
                icon: ProfileIcons.help,
                content: 'Ngôn ngữ',
                screen: '/faq',
              ),
              BuildItemButon(
                  colorbrg: Colors.orange,
                  icon: ProfileIcons.info,
                  content: 'Chủ đề theo dõi tin tức',
                  screen: '/info'),
              BuildItemButon(
                colorbrg: Colors.red,
                icon: ProfileIcons.support,
                content: 'Hỗ trợ',
                screen: '/support',
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
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black38,
              blurRadius: 1.0,
            ),
          ],
        ),
        child: Column(
          children: <Widget>[
            BuildItemButon(
              colorbrg: Colors.blue,
              icon: ProfileIcons.help,
              content: 'FAQ',
              screen: '/faq',
            ),
            InkWell(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: CustomIcon(
                            colorbackground: Colors.green,
                            coloricon: Colors.white,
                            iconData: ProfileIcons.star),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          'Đánh giá ứng dụng',
                          style: StylesText.content14BoldBlack,
                        ),
                      ),
                    ],
                  ),
                ),
                onTap: () {}),
            BuildItemButon(
                colorbrg: Colors.orange,
                icon: ProfileIcons.info,
                content: 'Về Fake News Filter',
                screen: '/info'),
            BuildItemButon(
              colorbrg: Colors.red,
              icon: ProfileIcons.support,
              content: 'Hỗ trợ',
              screen: '/support',
            ),
          ],
        ),
      )
    ],
  );
}

class BuildItemButon extends StatelessWidget {
  final Color colorbrg;
  final IconData icon;
  final String content;
  final String screen;
  BuildItemButon(
      {required this.icon,
      required this.colorbrg,
      required this.content,
      required this.screen});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: CustomIcon(
                colorbackground: colorbrg,
                coloricon: Colors.white,
                iconData: icon,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                content,
                style: StylesText.content14BoldBlack,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
