//Simply, a Repository pattern is such pattern where the business will ask for receipt and won’t know how the price is getting calculated and printed on the receipt.
import 'package:fake_news/core/services/local_storage/local_storage.dart';

abstract class LocalStorageRepo {
  Future<String?>? getApiKey();
  Future<String?> getUserId();
  Future<String?> getAuthToken();
  Future<String?>? getEmail();
  Future<String?> getIsNotFollow();
  Future<String?> getIsFinishOnboarding();
  Future<bool> saveApiKey(String apiKey);
  Future<bool> saveUserId(String userId);
  Future<bool> saveAuthToken(String authToken);
  Future<bool> saveEmail(String email);
  Future<bool> saveIsNotFollow(bool isNotFollow);
  Future<bool> saveFinishedOnboarding(bool isNotFinish);
  Future<bool> handleUnAuthorized();
}

class LocalStorageRepoImpl implements LocalStorageRepo {
  // local storage or remote api will be injected via constructor using DI
  // example:
  // Get.put(localStorage())
  // Get.put<AuthRepo>(AuthRepoImpl(localStorage: Get.find())
  LocalStorageRepoImpl({required this.localStorage});

  LocalStorage localStorage;

  String? _apiKey;

  @override
  Future<String?>? getApiKey({bool fromDisk = false}) async {
    if (!fromDisk) {
      return Future.value(_apiKey);
    }
    return localStorage.getApiKey();
  }

  @override
  Future<String?> getUserId() {
    return localStorage.getUserId();
  }

  @override
  Future<String?> getAuthToken() async {
    return localStorage.getAuthToken();
  }

  @override
  Future<String?>? getEmail() {
    return localStorage.getEmail();
  }

  @override
  Future<String?> getIsNotFollow() {
    return localStorage.getIsNotFollow();
  }

  @override
  Future<String?> getIsFinishOnboarding() {
    return localStorage.getIsFinishOnboarding();
  }

  @override
  Future<bool> saveApiKey(String apiKey) async {
    _apiKey = apiKey;
    return localStorage.saveApiKey(apiKey);
  }

  @override
  Future<bool> saveUserId(String userId) {
    return localStorage.saveUserId(userId);
  }

  @override
  Future<bool> saveAuthToken(String authToken) async =>
      localStorage.saveAuthToken(authToken);

  @override
  Future<bool> saveEmail(String email) async => localStorage.saveEmail(email);

  @override
  Future<bool> saveIsNotFollow(bool isNotFollow) async =>
      localStorage.saveIsNotFollow(isNotFollow);

  @override
  Future<bool> handleUnAuthorized() {
    return localStorage.handleUnAuthorized();
  }

  @override
  Future<bool> saveFinishedOnboarding(bool isNotFinish) {
    return localStorage.saveFinishedOnboarding(isNotFinish);
  }
}
