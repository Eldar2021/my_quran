import 'package:flutter/material.dart';

@immutable
final class AppSnackbar {
  static const Duration _snackBarDisplayDuration = Duration(milliseconds: 4000);

  static void showSnackbar(BuildContext context, String message, {Duration? duration}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: duration ?? _snackBarDisplayDuration),
    );
  }
}
