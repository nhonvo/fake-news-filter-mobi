import 'package:fake_news/providers/local_storage_repo.dart';
import 'package:fake_news/views/onboarding/onboarding_viewmodel.dart';
import 'package:get/instance_manager.dart';

class OnboardingBinding extends Bindings {
  LocalStorageRepo localRepo = Get.find();

  @override
  void dependencies() {
    Get.put<OnboardingViewModel>(OnboardingViewModel(localRepo: localRepo));
  }
}
