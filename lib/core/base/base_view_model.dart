import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class BaseViewModel extends GetxController {
  /// Print log
  void printLog({
    required String nameFunc,
    required String feature,
    required dynamic data,
  }) {
    if (!kReleaseMode) {
      print("[$nameFunc] _$feature data = $data");
    }
  }
}
