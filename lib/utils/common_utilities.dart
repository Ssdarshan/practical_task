import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum SnackBarType { error, success, warning }

commonSnackBar({required String? message, SnackBarType? type}) {
  Icon icon;
  Color backgroundColor;

  switch (type) {
    case SnackBarType.error:
      backgroundColor = Colors.red;
      icon = const Icon(
        Icons.error,
        color: Colors.white,
      );
      break;
    case SnackBarType.warning:
      backgroundColor = Colors.orangeAccent;
      icon = const Icon(
        Icons.warning,
        color: Colors.white,
      );
      break;
    case SnackBarType.success:
    default:
      backgroundColor = Colors.green;
      icon = const Icon(
        Icons.check_circle,
        color: Colors.white,
      );
      break;
  }
  return Get.rawSnackbar(
    borderRadius: 10,
    margin: const EdgeInsets.all(10),
    snackPosition: SnackPosition.BOTTOM,
    messageText: Text(
      message ?? "",
      style: const TextStyle(color: Colors.white),
    ),
    message: message ?? "",
    backgroundColor: backgroundColor,
    icon: icon,
    onTap: (_) {},
    shouldIconPulse: false,
    mainButton: const Padding(
      padding: EdgeInsets.only(right: 10),
      child: Icon(
        Icons.close,
        color: Colors.white,
      ),
    ),
    barBlur: 20,
    isDismissible: true,
    duration: Duration(seconds: 5),
    boxShadows: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.5), // Shadow color
        spreadRadius: 1, // Spread radius
        blurRadius: 10, // Blur radius
        offset: const Offset(0, 5), // Offset from the top
      ),
    ],
  );
}
