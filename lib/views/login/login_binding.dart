import 'package:fake_news/views/login/login_viewmodel.dart';
import 'package:get/instance_manager.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<LoginViewModel>(LoginViewModel());
  }
}
