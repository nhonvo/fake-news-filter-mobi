import 'dart:core';

import 'base_api_error_model.dart';

class BaseResponse<T> {
  bool? isSuccessed;
  T? resultObj;
  List<BaseApiError>? error;

  BaseResponse.fromJson(Map<String, dynamic> json,
      {T Function(dynamic json)? parseJson}) {
    isSuccessed = json["isSuccessed"] ?? false;
    resultObj =
        json['resultObj'] != null ? parseJson?.call(json['resultObj']) : null;
    error = json['massage'];
  }

  BaseResponse.initError(int code, String message) {
    error = [BaseApiError(message: message)];
  }
}
