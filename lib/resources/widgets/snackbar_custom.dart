import 'package:flutter/material.dart';
import 'package:get/get.dart';

void snackBar(String title, String message, String? altMessage, Widget icon, Color backgroundColor, Color colorText,
    SnackPosition? snackPosition) {
  Get.snackbar(
    title,
    message == "null" ? altMessage.toString() : message,
    icon: icon,
    backgroundColor: backgroundColor,
    colorText: colorText,
    snackPosition: snackPosition,
  );
}
