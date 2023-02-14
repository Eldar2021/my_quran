import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:hatim/components/components.dart';
import 'package:hatim/constants/contants.dart';
import 'package:hatim/l10n/l10.dart';
import 'package:hatim/models/user/user_model.dart';

class AppAlert {
  static Future<T?> showLoading<T>(BuildContext context) {
    return showCupertinoDialog<T>(
      context: context,
      builder: (context) {
        return AlertDialog(
          titlePadding: const EdgeInsets.fromLTRB(60, 30, 60, 30),
          title: Column(
            children: [
              const SizedBox(width: 60, height: 60, child: CircularProgressIndicator()),
              const SizedBox(height: 40),
              Text(context.l10n.pleaseWait, style: const TextStyle(fontSize: 20), textAlign: TextAlign.center),
            ],
          ),
          elevation: 10,
        );
      },
    );
  }

  static Future<T?> showAmin<T>(BuildContext context, Gender gender, {required bool isHatim, required int totalPages}) {
    final colorScheme = Theme.of(context).colorScheme;
    return showDialog<T>(
      context: context,
      builder: (context) {
        return AlertDialog(
          icon: gender == Gender.male
              ? Assets.icons.duaMale.svg(
                  height: 70,
                  colorFilter: ColorFilter.mode(colorScheme.onBackground, BlendMode.srcIn),
                )
              : Assets.icons.duaFemale.svg(height: 70),
          title: Text(context.l10n.amin),
          content: Text(context.l10n.aminDua, textAlign: TextAlign.center),
          actions: [
            CustomButton(
              text: context.l10n.amin,
              onPressed: () {
                if (isHatim) {
                  Navigator.of(context).pop(true);
                } else {
                  Navigator.of(context).pop(true);
                }
              },
            )
          ],
        );
      },
    );
  }
}
