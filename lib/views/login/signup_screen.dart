// ignore_for_file: prefer_const_constructors
import 'package:fake_news/services/language_service/language_service.dart';
import 'package:fake_news/resources/utils/image.dart';
import 'package:fake_news/resources/utils/style.dart';
import 'package:fake_news/resources/widgets/button.dart';
import 'package:fake_news/resources/widgets/textfield.dart';
import 'package:fake_news/views/language/choose_language_screen.dart';
import 'package:fake_news/views/login/login_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  LoginViewModel get viewmodel => Get.find<LoginViewModel>();

  bool _passwordObscureText = true;
  bool _confirmPasswordObscureText = true;
  bool checkbox = true;

  final language = Get.find<LanguageService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
            Colors.blue,
            Colors.white,
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
        ),
        child: Stack(
          alignment: Alignment.center,
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
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                    Text('Register', style: StylesText.content18BoldWhite),
                    SizedBox(
                      height: Get.size.height * 0.03,
                    ),
                    CustomTextField(
                      controller: viewmodel.usernameController,
                      // ignore: null_check_always_fails
                      hintText: 'inputuser'.tr,
                      suffixIcon: viewmodel.usernameController.text.isNotEmpty
                          ? IconButton(onPressed: viewmodel.clearText, icon: const Icon(Icons.clear))
                          : null,
                      width: Get.size.width * 0.7,
                      height: 40,
                      prefixIcon: const Icon(Icons.supervised_user_circle),
                      obscureText: false,
                    ),
                    SizedBox(
                      height: Get.size.height * 0.02,
                    ),
                    CustomTextField(
                      controller: viewmodel.nameController,
                      // ignore: null_check_always_fails
                      hintText: 'inputName'.tr,
                      suffixIcon: viewmodel.usernameController.text.isNotEmpty
                          ? IconButton(onPressed: viewmodel.clearText, icon: const Icon(Icons.clear))
                          : null,
                      width: Get.size.width * 0.7,
                      height: 40,
                      prefixIcon: const Icon(Icons.supervised_user_circle),
                      obscureText: false,
                    ),
                    SizedBox(
                      height: Get.size.height * 0.02,
                    ),
                    CustomTextField(
                      controller: viewmodel.emailController,
                      // ignore: null_check_always_fails
                      hintText: 'inputEmail'.tr,
                      suffixIcon: viewmodel.usernameController.text.isNotEmpty
                          ? IconButton(onPressed: viewmodel.clearText, icon: const Icon(Icons.clear))
                          : null,
                      width: Get.size.width * 0.7,
                      height: 40,
                      prefixIcon: const Icon(Icons.supervised_user_circle),
                      obscureText: false,
                    ),
                    SizedBox(
                      height: Get.size.height * 0.02,
                    ),
                    CustomTextField(
                      controller: viewmodel.phoneController,
                      // ignore: null_check_always_fails
                      hintText: 'inputPhone'.tr,
                      suffixIcon: viewmodel.phoneController.text.isNotEmpty
                          ? IconButton(onPressed: viewmodel.clearText, icon: const Icon(Icons.clear))
                          : null,
                      width: Get.size.width * 0.7,
                      height: 40,
                      prefixIcon: const Icon(Icons.supervised_user_circle),
                      obscureText: false,
                    ),
                    SizedBox(
                      height: Get.size.height * 0.02,
                    ),
                    CustomTextField(
                      controller: viewmodel.passwordController,
                      hintText: 'inputpass'.tr,
                      suffixIcon: InkWell(
                          onTap: () => setState(() {
                                _passwordObscureText = !_passwordObscureText;
                              }),
                          child: Icon(_passwordObscureText ? Icons.visibility_off : Icons.visibility)),
                      width: Get.size.width * 0.7,
                      height: 40,
                      prefixIcon: const Icon(Icons.supervised_user_circle),
                      obscureText: _passwordObscureText,
                    ),
                    SizedBox(
                      height: Get.size.height * 0.02,
                    ), //Password Text Field
                    CustomTextField(
                      controller: viewmodel.passwordConfirmController,
                      width: Get.size.width * 0.7,
                      prefixIcon: const Icon(Icons.security_outlined),
                      obscureText: _confirmPasswordObscureText,
                      suffixIcon: InkWell(
                          onTap: () => setState(() {
                                _confirmPasswordObscureText = !_confirmPasswordObscureText;
                              }),
                          child: Icon(_confirmPasswordObscureText ? Icons.visibility_off : Icons.visibility)),
                      hintText: 'inputPassConfirm'.tr,
                      height: 40,
                    ),
                  ],
                ),
                SizedBox(
                  height: Get.size.height * 0.02,
                ),
                CustomButton(
                  width: Get.size.width * 0.5,
                  height: Get.size.height * 0.015,
                  buttonText: 'Register',
                  buttonColor: MyColors.blueDart,
                  buttonRadius: 20,
                  textStyle: StylesText.content16BoldWhite,
                  onPressed: () {
                    viewmodel.handleRegister();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
