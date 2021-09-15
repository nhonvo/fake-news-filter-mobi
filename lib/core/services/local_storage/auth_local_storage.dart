import 'package:shared_preferences/shared_preferences.dart';
import 'package:fake_news/resources/utils/app_constant.dart';

abstract class AuthLocalStorage {
  Future<String?> getApiKey();

  Future<String?> getAuthToken();

  Future<bool> saveApiKey(String apiKey);

  Future<bool> saveAuthToken(String authToken);

  Future<bool> handleUnAuthorized();
}

// with shared pref
class AuthLocalStorageIpml implements AuthLocalStorage {
  SharedPreferences sharedPref;

  AuthLocalStorageIpml({required this.sharedPref});

  @override
  Future<String?> getApiKey() async {
    return sharedPref.getString(AppConstant.sharePrefKeys.apiKey)!;
  }

  @override
  Future<String?> getAuthToken() async {
    return sharedPref.getString(AppConstant.sharePrefKeys.authToken);
  }

  @override
  Future<bool> saveApiKey(String apiKey) async {
    return sharedPref.setString(AppConstant.sharePrefKeys.apiKey, apiKey);
  }

  @override
  Future<bool> saveAuthToken(String authToken) async {
    return sharedPref.setString(AppConstant.sharePrefKeys.authToken, authToken);
  }

  @override
  Future<bool> handleUnAuthorized() async {
    await sharedPref.remove(AppConstant.sharePrefKeys.authToken);
    await sharedPref.remove(AppConstant.sharePrefKeys.apiKey);
    return true;
  }
}
