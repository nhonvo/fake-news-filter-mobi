import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SnackbarCustom {
  static void show(
      {required String title,
      required String message,
      String? altMessage,
      required Widget icon,
      required Color backgroundColor,
      required Color colorText,
      SnackPosition? snackPosition = SnackPosition.BOTTOM}) {
    Get.snackbar(
      title,
      message == "null" ? altMessage.toString() : message,
      icon: icon,
      backgroundColor: backgroundColor,
      colorText: colorText,
      snackPosition: snackPosition,
    );
  }

  static void showError(
      {required String message,
      String? altMessage,
      SnackPosition? snackPosition}) {
    Get.snackbar(
      'error'.tr,
      message == "null" ? altMessage.toString() : message,
      icon: Icon(
        Icons.error,
        color: Colors.white,
      ),
      backgroundColor: Colors.red,
      colorText: Colors.white,
      snackPosition: snackPosition,
    );
  }
}
