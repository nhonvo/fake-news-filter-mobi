import 'package:fake_news/core/base/base_view_model.dart';
import 'package:fake_news/providers/local_storage_repo.dart';

class OnboardingViewModel extends BaseViewModel {
  OnboardingViewModel({required this.localRepo});

  LocalStorageRepo localRepo;
}
