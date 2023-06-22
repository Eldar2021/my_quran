import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

@immutable
final class AppLaunch {
  static Future<void> sendEmail(String email, {String? snackBarText, BuildContext? context}) async {
    try {
      final isSuccess = await launchUrl(Uri(scheme: 'mailto', path: email));
      if (!isSuccess && snackBarText != null && context != null && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(snackBarText)));
      }
    } catch (e, s) {
      log('launch Error: $e, \n launch StackTrace: $s');
    }
  }

  static Future<void> sendTelegram({required String username, String? message}) async {
    Uri? url;
    try {
      if (message != null && message != '') {
        url = Uri.parse('https://t.me/$username?text=${Uri.encodeFull(message)}');
      } else {
        url = Uri.parse('https://t.me/$username');
      }
      await launchUrl(
        url,
        mode: LaunchMode.externalNonBrowserApplication,
        webOnlyWindowName: username,
        webViewConfiguration: const WebViewConfiguration(
          headers: <String, String>{
            'User-Agent': 'Telegram',
          },
        ),
      );
      if (kDebugMode) {
        if (message != null && message != '') {
          print(
            '\x1B[32mSending message to $username...\nMessage: $message\x1B[0m\nURL: https://t.me/$username?text=${Uri.encodeFull(message)}',
          );
        } else {
          print('\x1B[32mSending message to $username...\x1B[0m');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('\x1B[31mSending failed!\nError: $e\x1B[0m');
      }
    }
  }

  static Future<void> sendWhatsApp({required String phoneNumber, String? message}) async {
    Uri? url;
    try {
      if (message != null && message != '') {
        url = Uri.parse('https://wa.me/$phoneNumber?text=${Uri.encodeFull(message)}');
      } else {
        url = Uri.parse('https://wa.me/$phoneNumber');
      }
      await launchUrl(url);
      if (kDebugMode) {
        if (message != null && message != '') {
          print(
            '\x1B[32mSending message to $phoneNumber via WhatsApp...\nMessage: $message\x1B[0m\nURL: https://wa.me/$phoneNumber?text=${Uri.encodeFull(message)}',
          );
        } else {
          print('\x1B[32mSending message to $phoneNumber via WhatsApp...\x1B[0m');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('\x1B[31mSending failed via WhatsApp!\nError: $e\x1B[0m');
      }
    }
  }

  static Future<void> launchURL(String url, {String? snackBarText, BuildContext? context}) async {
    try {
      final isSuccess = await launchUrl(Uri.parse(url));
      if (!isSuccess && snackBarText != null && context != null && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(snackBarText)));
      }
    } catch (e, s) {
      log('launch Error: $e, \n launch StackTrace: $s');
    }
  }
}
