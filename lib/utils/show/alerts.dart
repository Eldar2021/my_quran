import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:my_quran/components/components.dart';
import 'package:my_quran/constants/contants.dart';
import 'package:my_quran/l10n/l10.dart';
import 'package:my_quran/models/user/user_model.dart';

class AppAlert {
  static Future<T?> showLoading<T>(BuildContext context) {
    return showCupertinoDialog<T>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Center(
            child: SizedBox(
              width: 80,
              height: 80,
              child: CircularProgressIndicator(),
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
