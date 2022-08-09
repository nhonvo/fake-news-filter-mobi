import 'package:shared_preferences/shared_preferences.dart';
import 'package:fake_news/resources/utils/app_constant.dart';

abstract class LocalStorage {
  Future<String?> getApiKey();
  Future<String?> getUserId();
  Future<String?> getAuthToken();
  Future<String?> getEmail();
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

// with shared pref
class LocalStorageIpml implements LocalStorage {
  SharedPreferences sharedPref;

  LocalStorageIpml({required this.sharedPref});

  @override
  Future<String?> getApiKey() async {
    return sharedPref.getString(AppConstant.sharePrefKeys.apiKey)!;
  }

  @override
  Future<String?> getUserId() async {
    return sharedPref.getString(AppConstant.sharePrefKeys.userId);
  }

  @override
  Future<String?> getAuthToken() async {
    return sharedPref.getString(AppConstant.sharePrefKeys.authToken);
  }

  @override
  Future<String?> getEmail() async {
    return sharedPref.getString(AppConstant.sharePrefKeys.email);
  }

  @override
  Future<String?> getIsNotFollow() async {
    return sharedPref.getString(AppConstant.sharePrefKeys.isNotFollow);
  }

  @override
  Future<String?> getIsFinishOnboarding() async {
    return sharedPref.getString(AppConstant.sharePrefKeys.isFinishOnboarding);
  }

  @override
  Future<bool> saveApiKey(String apiKey) async {
    return await sharedPref.setString(AppConstant.sharePrefKeys.apiKey, apiKey);
  }

  @override
  Future<bool> saveUserId(String userId) async {
    return await sharedPref.setString(AppConstant.sharePrefKeys.userId, userId);
  }

  @override
  Future<bool> saveAuthToken(String authToken) async {
    return await sharedPref.setString(
        AppConstant.sharePrefKeys.authToken, authToken);
  }

  @override
  Future<bool> saveEmail(String email) async {
    return await sharedPref.setString(AppConstant.sharePrefKeys.email, email);
  }

  @override
  Future<bool> saveIsNotFollow(bool isNotFollow) async {
    return await sharedPref.setString(
        AppConstant.sharePrefKeys.isNotFollow, isNotFollow.toString());
  }

  @override
  Future<bool> saveFinishedOnboarding(bool isNotFinish) async {
    return await sharedPref.setString(
        AppConstant.sharePrefKeys.isFinishOnboarding, isNotFinish.toString());
  }

  @override
  Future<bool> handleUnAuthorized() async {
    await sharedPref.remove(AppConstant.sharePrefKeys.authToken);
    await sharedPref.remove(AppConstant.sharePrefKeys.apiKey);
    await sharedPref.remove(AppConstant.sharePrefKeys.userId);
    await sharedPref.remove(AppConstant.sharePrefKeys.email);
    await sharedPref.remove(AppConstant.sharePrefKeys.isNotFollow);
    return true;
  }
}
