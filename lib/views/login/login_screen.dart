// ignore_for_file: prefer_const_constructors
import 'package:fake_news/resources/utils/icon.dart';
import 'package:fake_news/services/language_service/language_service.dart';
import 'package:fake_news/resources/utils/image.dart';
import 'package:fake_news/resources/utils/style.dart';
import 'package:fake_news/resources/widgets/button.dart';
import 'package:fake_news/resources/widgets/textfield.dart';
import 'package:fake_news/views/language/choose_language_screen.dart';
import 'package:fake_news/views/login/login_viewmodel.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../resources/utils/app_routes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginViewModel get viewmodel => Get.find<LoginViewModel>();

  bool _obscureText = true;
  bool checkbox = true;

  final language = Get.find<LanguageService>();

  void toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
            Colors.blue,
            Colors.white,
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
        ),
        child: Stack(
          children: [
            Positioned(
              top: Get.size.height * 0.04,
              left: Get.size.width * 0.75,
              child: CustomButton(
                width: Get.size.width * 0.2,
                buttonText: 'klanguage'.tr,
                buttonColor: MyColors.blueLight,
                buttonRadius: 10,
                textStyle: StylesText.content12MediumBlue,
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return ChooseLanguageScreen();
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  );
                },
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(top: 46),
                  child: Column(
                    children: <Widget>[
                      SvgPicture.asset(
                        Images.logo,
                        width: Get.size.width * 0.2,
                      ),
                      Text('appname'.tr, style: StylesText.content16BoldWhite)
                    ],
                  ),
                ),
                Column(
                  children: <Widget>[
                    Text('login'.tr, style: StylesText.content18BoldWhite),
                    SizedBox(
                      height: Get.size.height * 0.025,
                    ),
                    //Account Text Field
                    CustomTextField(
                      controller: viewmodel.usernameController,
                      // ignore: null_check_always_fails
                      hintText: 'inputuser'.tr,
                      suffixIcon: viewmodel.usernameController.text.isNotEmpty
                          ? IconButton(
                              onPressed: viewmodel.clearText,
                              icon: const Icon(Icons.clear))
                          : null,
                      width: Get.size.width * 0.7,
                      prefixIcon: const Icon(Icons.supervised_user_circle),
                      obscureText: false,
                    ),
                    SizedBox(
                      height: Get.size.height * 0.03,
                    ), //Password Text Field
                    CustomTextField(
                      controller: viewmodel.passwordController,
                      width: Get.size.width * 0.7,
                      prefixIcon: const Icon(Icons.security_outlined),
                      obscureText: _obscureText,
                      suffixIcon: InkWell(
                          onTap: toggle,
                          child: Icon(_obscureText
                              ? Icons.visibility_off
                              : Icons.visibility)),
                      hintText: 'inputpass'.tr,
                    ),
                  ],
                ),
                SizedBox(
                  height: Get.size.height * 0.02,
                ),
                CustomButton(
                  width: Get.size.width * 0.5,
                  height: Get.size.height * 0.015,
                  buttonText: 'login',
                  buttonColor: MyColors.blueDart,
                  buttonRadius: 20,
                  textStyle: StylesText.content16BoldWhite,
                  onPressed: () {
                    viewmodel.handleLogin();
                  },
                ),
                Row(
                  children: <Widget>[
                    Text('noAccount'.tr, style: StylesText.content16BoldBlack),
                    TextButton(
                      child: Text(
                        'signUp'.tr,
                        style: StylesText.content16BoldBlue,
                      ),
                      onPressed: () => Get.toNamed(Routes.SIGNUP),
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
                Text(
                  'or'.tr,
                  style: StylesText.content18BoldBlack,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomIconButton(
                      width: Get.size.width * 0.35,
                      buttonText: '',
                      icon: const Icon(FontAwesomeIcons.facebookF,
                          color: Colors.white),
                      buttonColor: Colors.blue,
                      buttonRadius: 14,
                      textStyle: StylesText.content18BoldWhite,
                      onPressed: () {
                        viewmodel.handleLoginFacebook();
                      },
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    CustomIconButton(
                      width: Get.size.width * 0.35,
                      buttonText: '',
                      icon: const Icon(FontAwesomeIcons.google,
                          color: Colors.white),
                      buttonColor: Colors.red,
                      buttonRadius: 14,
                      textStyle: StylesText.content18BoldWhite,
                      onPressed: () {
                        viewmodel.handleLoginGoogle();
                      },
                    ),
                  ],
                ),
                Text(
                  'help'.tr,
                  style: StylesText.content16BoldBlack,
                ),
                _buildTermOfUse(context),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTermOfUse(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(top: 50, bottom: 20),
        height: 60,
        width: Get.size.width * 0.87,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(13),
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
              ),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Container(
              width: Get.size.width * 0.65,
              alignment: Alignment.center,
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: 'agree'.tr,
                  style: StylesText.content16LightBlack,
                  children: <TextSpan>[
                    TextSpan(
                        text: 'terms'.tr,
                        style: StylesText.content16MediumBlue,
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return _buildDetailTermsOfUse();
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                            );
                          }),
                    TextSpan(
                      text: 'about'.tr,
                      style: StylesText.content16LightBlack,
                    ),
                  ],
                ),
              ),
            ),
            Checkbox(
              value: checkbox,
              activeColor: MyColors.blue,
              onChanged: (index) {
                setState(() {
                  checkbox = index!;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailTermsOfUse() {
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
            'CHÍNH SÁCH VÀ ĐIỀU KHOẢN',
            style: StylesText.content17BoldBlue,
          )),
          const SizedBox(
            height: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildTextBold('Chúng tôi thu thập những thông tin gì?'),
              _buildTextMedium(
                  '- Chúng tôi thu thập thông tin từ bạn khi bạn điền vào một biểu mẫu.'),
              _buildTextMedium(
                  '- Chúng tôi có thể thu thập các thông tin như tên thiết bị, hệ điều hành, kích cỡ màn hình ngôn ngữ và vị trí.'),
              const SizedBox(
                height: 5,
              ),
              _buildTextBold('Chúng tôi sử dụng thông tin của bạn để làm gì?'),
              _buildTextMedium(
                  '- Để cá nhân hoá trải nghiệm của bạn: Thông tin của bạn sẽ giúp chúng tôi đáp ứng nhu cầu cá nhân của bạn.'),
              _buildTextMedium(
                  '- Để cải thiện ứng dụng: Thông tin của bạn sẽ giúp chúng tôi đáp ứng tốt hơn các yêu cầu dịch vụ và nhu cầu hỗ trợ'),
              const SizedBox(
                height: 5,
              ),
              _buildTextBold('Chính sách bảo mật trực tuyến'),
              _buildTextMedium(
                  'Chính sách bảo mật trực tuyến này chỉ áp dụng cho các thông tin thu thập được thông qua trang web, ứng dụng của chúng tôi và không để thu thập thông tin ẩn.'),
              const SizedBox(
                height: 5,
              ),
              _buildTextBold('Sự đồng ý của bạn'),
              _buildTextMedium(
                  'Bằng cách sử dụng ứng dụng, bạn bằng lòng với chính sách riêng tư của chúng tôi.'),
              _buildTextBold('Thay đổi chính sách bảo mật của chúng tôi'),
              _buildTextMedium(
                  'Nếu có bất kỳ câu hỏi liên quan đến chính sách bảo mật này, bạn có thể liên hệ với chúng tôi')
            ],
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
                  setState(() {
                    checkbox = true;
                  });
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

  Widget _buildTextBold(String content) {
    return Text(
      content,
      style: StylesText.content16BoldBlack.merge(const TextStyle(height: 1.4)),
    );
  }

  Widget _buildTextMedium(String content) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Text(
        content,
        style:
            StylesText.content14MediumBlack.merge(const TextStyle(height: 1.4)),
      ),
    );
  }
}
