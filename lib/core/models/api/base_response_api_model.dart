import 'dart:core';

class BaseResponse<T> {
  bool? isSuccessed;
  T? resultObj;
  String? messages;

  BaseResponse.fromJson(Map<String, dynamic> json, {T Function(dynamic json)? parseJson}) {
    isSuccessed = json["isSuccessed"] ?? false;
    resultObj = json['resultObj'] != null ? parseJson?.call(json['resultObj']) : null;
    messages = json['message'];
  }

  BaseResponse.initError(int code, String message) {
    messages = message;
    this.isSuccessed = false;
  }
}
