import 'package:flutter/material.dart';

class SnackbarHelper {
  static void show(
    BuildContext context,
    String message, {
    Color backgroundColor = const Color(0xFF7E22CE),
    Color textColor = Colors.white,
    Duration duration = const Duration(seconds: 2),
    SnackBarAction? action,
  }) {
    final snackBar = SnackBar(
      content: Text(
        textAlign: TextAlign.center,
        message,
        style: TextStyle(color: textColor, fontWeight: FontWeight.w500),
      ),
      backgroundColor: backgroundColor,
      duration: duration,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      action: action,
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}
