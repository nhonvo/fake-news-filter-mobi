// ignore_for_file: unnecessary_null_comparison

import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:fake_news/core/models/api/base_response_api_model.dart';
import 'package:fake_news/languages/language_service.dart';
import 'package:fake_news/providers/auth_repo.dart';
import 'package:fake_news/resources/utils/app_config.dart';
import 'package:fake_news/resources/utils/app_constant.dart';
import 'package:fake_news/resources/utils/app_routes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart' as getX;

abstract class Api {
  String baseApiUrl = getX.Get.find<AppEnvironment>().apiBaseUrl;
  AuthRepo authRepo;
  Api(this.authRepo);
  String _checkHost = 'google.com';

  Future<Map<String, String>> getHeader() async {
    Map<String, String> header = {"accept": "application/json", "content-type": "application/json"};

    var apikey = await authRepo.getApiKey();
    if (apikey != null) {
      header.addAll({"X-APP-ID": apikey});
    }

    var curLanguage = getX.Get.find<LanguageService>().currentLanguage;
    if (curLanguage != null) {
      header.addAll({"Accept-Language": curLanguage});
    }

    var token = await authRepo.getAuthToken();
    if (token != null) {
      header.addAll({"Authorization": "Bearer " + token});
    }
    return header;
  }

  Future<BaseResponse<T>> doGet<T>(
    String url, {
    Map<String, dynamic>? queryParams,
    T Function(dynamic json)? parseJson,
  });

  Future<BaseResponse<T>> doPost<T>(
    String url,
    dynamic body, {
    T Function(dynamic json)? parseJson,
  });

  Future<BaseResponse<T>> doPut<T>(
    String url,
    dynamic body, {
    T Function(dynamic json)? parseJson,
  });
  Future<BaseResponse<T>> doDelete<T>(
    String url, {
    T Function(dynamic json)? parseJson,
  });
  Future<BaseResponse<T>> handleResponse<T>(response);
  Future<BaseResponse<T>> handleInternalError<T>(error);

  Future<void> handleUnAuthorized() async {
    SharedPreferences pref = getX.Get.find();

    await Future.wait([
      // pref.remove(AppConstant.sharePrefKeys.authToken),
      pref.remove(AppConstant.sharePrefKeys.firstName),
      pref.remove(AppConstant.sharePrefKeys.lastName),
      pref.remove(AppConstant.sharePrefKeys.email),
      pref.remove(AppConstant.sharePrefKeys.phone),
      pref.remove(AppConstant.sharePrefKeys.countryCode),
      pref.remove(AppConstant.sharePrefKeys.avatar),
      authRepo.saveAuthToken(''),
    ]);
    if (getX.Get.currentRoute != Routes.LOGIN) getX.Get.offAllNamed(Routes.LOGIN);
  }

  Future<bool> checkBadInternet() async {
    try {
      if (getX.GetPlatform.isWeb) {
        return false;
      }
      final result = await InternetAddress.lookup(_checkHost);
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return false;
      }
    } on SocketException catch (_) {
      return true;
    }
    return true;
  }
}

class DioApi extends Api {
  Dio dio = Dio(BaseOptions(connectTimeout: 30000, receiveTimeout: 30000, sendTimeout: 30000));

  DioApi({required AuthRepo authRepo}) : super(authRepo) {
    if (!kReleaseMode) {
      dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
    }
  }

  Future<BaseResponse<T>> handleDioResponse<T>(Response response, {T Function(dynamic json)? parseJson}) async {
    try {
      if (response.statusCode! >= 200 && response.statusCode! <= 499) {
        if (response.statusCode == 401) {
          await handleUnAuthorized();
          // var error = BaseResponse<T>.initError(
          //     response.statusCode, AppConstant.errorMessage.invalidAccess);
          var error = BaseResponse<T>.fromJson({'A': 'B'});
          return error;
        }
        var result = BaseResponse<T>.fromJson(response.data, parseJson: parseJson);
        return result;
      } else {
        var error = BaseResponse<T>.initError(response.statusCode!, AppConstant.errorMessage.anErrorOccured);
        return error;
      }
    } catch (error) {
      return handleInternalError<T>(error);
    }
  }

  @override
  Future<BaseResponse<T>> handleInternalError<T>(error) async {
    if (error is DioError) {
      return await handleDioError<T>(error);
    }
    if (error is TimeoutException) {
      return BaseResponse<T>.initError(-9999, 'Your request time out');
    }
    if (error is SocketException) if (error.osError != null) {
      if (error.osError?.errorCode == 8) {
        return BaseResponse<T>.initError(
            error.osError?.errorCode ?? -999, 'The internet connection appears to be offline, please try again');
      } else {
        return BaseResponse<T>.initError(error.osError?.errorCode ?? -999, error.osError!.message);
      }
    } else {
      return BaseResponse<T>.initError(
          error.osError?.errorCode ?? -999, 'The internet connection appears to be offline, please try again');
    }
    if (error is NoSuchMethodError) {
      return BaseResponse<T>.initError(-1, 'Error when getting data');
    }
    if (error is TypeError) {
      return BaseResponse<T>.initError(-2, 'Error when converting data');
    }

    return BaseResponse.initError(-999, error?.message ?? 'An error occured');
  }

  @override
  Future<BaseResponse<T>> handleResponse<T>(response, {T Function(dynamic json)? parseJson}) async {
    if (response is Response) {
      return await handleDioResponse<T>(response, parseJson: parseJson);
    } else {
      return await handleInternalError(response);
    }
  }

  Future<BaseResponse<T>> handleDioError<T>(DioError dioError) async {
    switch (dioError.type) {
      case DioErrorType.connectTimeout:
        return BaseResponse<T>.initError(-9999, 'Your request time out');
      case DioErrorType.sendTimeout:
        return BaseResponse<T>.initError(-9999, 'Your request time out');

      case DioErrorType.receiveTimeout:
        return BaseResponse<T>.initError(-9999, 'Your request time out');

      case DioErrorType.response:
        if (dioError.response?.statusCode == 502) {
          return BaseResponse<T>.initError(502, 'Server die');
        }
        if (dioError.response?.statusCode == 401) {
          await handleUnAuthorized();
          var error = BaseResponse<T>.fromJson({'A': 'B'});
          return error;
        }
        var error = dioError.response!.data['message'].toString();
        var errorCode;
        errorCode = dioError.response?.statusCode ?? -9999;

        var errorMessage = error != null ? error : 'Server error, please try again, code: $errorCode';
        print("ERRRRrrrrrrrrr $error");
        return BaseResponse<T>.initError(errorCode, errorMessage);

      case DioErrorType.cancel:
        return BaseResponse<T>.initError(-9999, 'Cancelled, please try again');
      default:
        return BaseResponse<T>.initError(
          dioError.response?.statusCode ?? -9999,
          dioError.message,
        );
    }
  }

  @override
  Future<BaseResponse<T>> doGet<T>(
    String url, {
    Map<String, dynamic>? queryParams,
    T Function(dynamic json)? parseJson,
    bool needThrowError = false,
  }) async {
    try {
      if (await checkBadInternet()) {
        return BaseResponse<T>.initError(-999, AppConstant.errorMessage.badInternetConnection);
      }
      var header = await getHeader();
      var response = await dio.get(baseApiUrl + url, options: Options(headers: header), queryParameters: queryParams);
      return await handleResponse<T>(response, parseJson: parseJson);
    } catch (e) {
      if (needThrowError) {
        rethrow;
      } else {
        return handleInternalError<T>(e);
      }
    }
  }

  @override
  Future<BaseResponse<T>> doPost<T>(String url, dynamic body,
      {bool needThrowError = false, T Function(dynamic json)? parseJson}) async {
    try {
      if (await checkBadInternet()) {
        return BaseResponse<T>.initError(-999, AppConstant.errorMessage.badInternetConnection);
      }
      var header = await getHeader();
      var response = await dio.post(baseApiUrl + url, data: body, options: Options(headers: header));
      print('api response $response');
      return handleResponse<T>(response, parseJson: parseJson);
    } catch (e) {
      if (needThrowError) {
        rethrow;
      } else {
        return handleInternalError<T>(e);
      }
    }
  }

  @override
  Future<BaseResponse<T>> doPut<T>(String url, dynamic body,
      {bool needThrowError = false, T Function(dynamic json)? parseJson}) async {
    try {
      if (await checkBadInternet()) {
        return BaseResponse<T>.initError(-999, AppConstant.errorMessage.badInternetConnection);
      }
      var header = await getHeader();

      var response = await dio.put(baseApiUrl + url, options: Options(headers: header), data: body);
      return handleResponse<T>(response, parseJson: parseJson);
    } catch (e) {
      if (needThrowError) {
        rethrow;
      } else {
        return handleInternalError<T>(e);
      }
    }
  }

  @override
  Future<BaseResponse<T>> doDelete<T>(String url,
      {bool needThrowError = false, T Function(dynamic json)? parseJson}) async {
    try {
      if (await checkBadInternet()) {
        return BaseResponse<T>.initError(-999, AppConstant.errorMessage.badInternetConnection);
      }
      var header = await getHeader();
      var response = await dio.delete(baseApiUrl + url, options: Options(headers: header));
      return handleResponse<T>(response, parseJson: parseJson);
    } catch (e) {
      if (needThrowError) {
        rethrow;
      } else {
        return handleInternalError<T>(e);
      }
    }
  }
}
