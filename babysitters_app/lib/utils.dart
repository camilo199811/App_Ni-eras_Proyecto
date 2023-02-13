import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class Utils {
  static void ShowFlushBar({
    required BuildContext context,
    required String title,
    required String message,
    required Color color,
  }) {
    Flushbar(
      title: title,
      message: message,
      backgroundColor: color,
      duration: const Duration(seconds: 4),
    ).show(context);
  }
}
