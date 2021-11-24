import 'package:fake_news/core/api/auth_api.dart';
import 'package:fake_news/providers/auth_repo.dart';
import 'package:fake_news/views/login/login_viewmodel.dart';
import 'package:get/instance_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginBinding extends Bindings {
  AuthApi authApi = Get.find();
  AuthRepo authRepo = Get.find();
  SharedPreferences pref = Get.find();

  @override
  void dependencies() {
    Get.put<LoginViewModel>(LoginViewModel(authApi: authApi, authRepo: authRepo, pref: pref));
  }
}
