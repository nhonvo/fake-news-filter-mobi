import 'package:fake_news/core/api/auth_api.dart';
import 'package:fake_news/core/base/base_view_model.dart';
import 'package:fake_news/core/services/local_storage/auth_local_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginViewModel extends BaseViewModel {
  var usernameController = TextEditingController();
  var passwordController = TextEditingController();

  void clearText() {
    usernameController.clear();
  }

  AuthApi loginService = Get.find();

  handlelogin() async {
    var response = await loginService.login(
        usernameController.text, passwordController.text);
        
  }
}
