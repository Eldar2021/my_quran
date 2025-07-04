import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

const _erroDuraition = Duration(seconds: 5);
const _successDuraition = Duration(seconds: 2);
const _infoDuraition = Duration(seconds: 5);

@immutable
final class AppSnackbar {
  static void showSnackbar(BuildContext context, String message, {Duration? duration}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message), duration: duration ?? _infoDuraition));
  }

  static void hideCurrentSnackbar() {
    toastification.dismissAll();
  }

  static void showError({required BuildContext context, required String title, String? message}) {
    toastification.show(
      context: context,
      title: Text(title.trim(), maxLines: 5, textAlign: TextAlign.left),
      description: message == null ? null : Text(message),
      type: ToastificationType.error,
      style: ToastificationStyle.fillColored,
      alignment: Alignment.topCenter,
      autoCloseDuration: _erroDuraition,
      showProgressBar: false,
    );
  }

  static void showSuccess({required BuildContext context, required String title, String? message}) {
    toastification.show(
      context: context,
      title: Text(title.trim(), maxLines: 5, textAlign: TextAlign.left),
      description: message == null ? null : Text(message),
      type: ToastificationType.success,
      style: ToastificationStyle.fillColored,
      alignment: Alignment.topCenter,
      autoCloseDuration: _successDuraition,
      showProgressBar: false,
    );
  }

  static void showInfo({required BuildContext context, required String title, String? message}) {
    toastification.show(
      context: context,
      title: Text(title.trim(), maxLines: 2, textAlign: TextAlign.left),
      description: message == null ? null : Text(message),
      type: ToastificationType.info,
      style: ToastificationStyle.fillColored,
      alignment: Alignment.topCenter,
      autoCloseDuration: _infoDuraition,
      showProgressBar: false,
    );
  }
}
