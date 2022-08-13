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
      SnackPosition? snackPosition = SnackPosition.BOTTOM}) {
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

  static void showInfo(
      {required String message,
      String? altMessage,
      SnackPosition? snackPosition = SnackPosition.BOTTOM}) {
    Get.snackbar(
      'info'.tr,
      message == "null" ? altMessage.toString() : message,
      icon: Icon(
        Icons.error,
        color: Colors.white,
      ),
      backgroundColor: Colors.blue,
      colorText: Colors.white,
      snackPosition: snackPosition,
      duration: const Duration(seconds: 1),
    );
  }

  static void showWarning(
      {required String message,
      String? altMessage,
      SnackPosition? snackPosition = SnackPosition.BOTTOM}) {
    Get.snackbar(
      'warning'.tr,
      message == "null" ? altMessage.toString() : message,
      icon: Icon(
        Icons.error,
        color: Colors.white,
      ),
      backgroundColor: Colors.amber,
      colorText: Colors.white,
      snackPosition: snackPosition,
      duration: const Duration(seconds: 1),
    );
  }
}
