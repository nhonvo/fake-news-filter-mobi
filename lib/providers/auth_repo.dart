//Simply, a Repository pattern is such pattern where the business will ask for receipt and won’t know how the price is getting calculated and printed on the receipt.
import 'package:fake_news/core/services/local_storage/auth_local_storage.dart';
import 'package:fake_news/models/users/user_model.dart';

abstract class AuthRepo {
  Future<String?>? getApiKey();
  Future<String?> getUserId();
  Future<String?> getAuthToken();
  Future<String?>? getEmail();
  Future<String?> getIsNotFollow();
  Future<bool> saveApiKey(String apiKey);
  Future<bool> saveUserId(String userId);
  Future<bool> saveAuthToken(String authToken);
  Future<bool> saveEmail(String email);
  Future<bool> saveIsNotFollow(bool isNotFollow);
  Future<bool> handleUnAuthorized();
}

class AuthRepoImpl implements AuthRepo {
  // local storage or remote api will be injected via constructor using DI
  // example:
  // Get.put(AuthLocalStorage())
  // Get.put<AuthRepo>(AuthRepoImpl(localStorage: Get.find())
  AuthRepoImpl({required this.authLocalStorage});

  AuthLocalStorage authLocalStorage;

  String? _apiKey;

  @override
  Future<String?>? getApiKey({bool fromDisk = false}) async {
    if (!fromDisk) {
      return Future.value(_apiKey);
    }
    return authLocalStorage.getApiKey();
  }

  @override
  Future<String?> getUserId() {
    return authLocalStorage.getUserId();
  }

  @override
  Future<String?> getAuthToken() async {
    return authLocalStorage.getAuthToken();
  }

  @override
  Future<String?>? getEmail() {
    return authLocalStorage.getEmail();
  }

  @override
  Future<String?> getIsNotFollow() {
    return authLocalStorage.getIsNotFollow();
  }

  @override
  Future<bool> saveApiKey(String apiKey) async {
    _apiKey = apiKey;
    return authLocalStorage.saveApiKey(apiKey);
  }

  @override
  Future<bool> saveUserId(String userId) {
    return authLocalStorage.saveUserId(userId);
  }

  @override
  Future<bool> saveAuthToken(String authToken) async => authLocalStorage.saveAuthToken(authToken);

  @override
  Future<bool> saveEmail(String email) async => authLocalStorage.saveEmail(email);

  @override
  Future<bool> saveIsNotFollow(bool isNotFollow) async => authLocalStorage.saveIsNotFollow(isNotFollow);

  @override
  Future<bool> handleUnAuthorized() {
    return authLocalStorage.handleUnAuthorized();
  }
}
