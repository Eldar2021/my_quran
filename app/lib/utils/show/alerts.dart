import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_quran/l10n/l10.dart';

@immutable
final class AppAlert {
  static Future<T?> showLoading<T>(BuildContext context) {
    return showCupertinoDialog<T>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Center(
            child: SizedBox(
              width: 80,
              height: 80,
              child: CupertinoActivityIndicator(
                color: Theme.of(context).colorScheme.primary,
                radius: 16,
              ),
            ),
          ),
          content: Text(
            context.l10n.pleaseWait,
            style: const TextStyle(fontSize: 18),
            textAlign: TextAlign.center,
          ),
        );
      },
    );
  }

  static void showErrorDialog(
    BuildContext context, {
    required String errorText,
    Widget? title,
    void Function()? onPressed,
    TextStyle? textStyle,
  }) {
    showCupertinoDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text(context.l10n.error),
          content: Text(errorText, style: textStyle),
          actions: <Widget>[
            CupertinoButton(
              onPressed: onPressed ?? () => context.pop(),
              child: Text(context.l10n.cancel, style: textStyle),
            ),
          ],
        );
      },
    );
  }

  static void showRestartDialog(BuildContext context) {
    showCupertinoDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text(context.l10n.restartApp),
          content: Text(context.l10n.restartForDevMode),
          actions: <Widget>[
            CupertinoButton(
              onPressed: () => exit(0),
              child: Text(context.l10n.restart),
            ),
          ],
        );
      },
    );
  }
}
