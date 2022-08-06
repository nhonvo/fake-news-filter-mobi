import 'dart:core';

class BaseResponse<T> {
  int? statusCode;
  T? resultObj;
  String? message;

  BaseResponse.fromJson(Map<String, dynamic> json,
      {T Function(dynamic json)? parseJson}) {
    statusCode = json["statusCode"]!;
    resultObj =
        json['resultObj'] != null ? parseJson?.call(json['resultObj']) : null;
    message = json['message'] ?? "An error has occurred!";
  }

  BaseResponse.initError(int code, String message) {
    message = message;
    this.statusCode = 400;
  }
}
