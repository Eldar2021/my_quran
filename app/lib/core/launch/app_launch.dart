// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AppLaunch {
  static Future<void> sendEmail(String email, {String? snackBarText, BuildContext? context}) async {
    try {
      final isSuccess = await launchUrl(Uri(scheme: 'mailto', path: email));
      if (!isSuccess && snackBarText != null && context != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(snackBarText)),
        );
      }
    } catch (e, s) {
      log('launch Error: $e, \n launch StackTrace: $s');
    }
  }

  static Future<void> launchURL(String url, {String? snackBarText, BuildContext? context}) async {
    try {
      final isSuccess = await launchUrl(Uri.parse(url));
      if (!isSuccess && snackBarText != null && context != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(snackBarText)),
        );
      }
    } catch (e, s) {
      log('launch Error: $e, \n launch StackTrace: $s');
    }
  }
}
