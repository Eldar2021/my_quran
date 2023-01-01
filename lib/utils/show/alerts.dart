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
        return CupertinoAlertDialog(
          title: Text(context.l10n.localeName),
          content: const Center(child: CupertinoActivityIndicator()),
        );
      },
    );
  }

  static Future<T?> showAmin<T>(BuildContext context, Gender gender, {bool isHatim = false}) {
    final colorScheme = Theme.of(context).colorScheme;
    return showDialog<T>(
      context: context,
      builder: (context) {
        return AlertDialog(
          icon: gender == Gender.male
              ? Assets.icons.duaMale.svg(height: 70, color: colorScheme.onBackground)
              : Assets.icons.duaFemale.svg(height: 70),
          title: const Text('Amin'),
          content: const Text(
            'ListTile must be wrapped in a Material widget to animate tileColor, selectedTileColor, focusColor, and hoverColor as these colors are not drawn by the list tile itself but by the material widget ancestor.',
          ),
          actions: [
            CustomButton(
              text: 'Amin',
              onPressed: () {
                if (isHatim) {
                  //Navigator.popUntil(context, (route) => false);
                }
                Navigator.popUntil(context, (route) => route.isFirst);
              },
            )
          ],
        );
      },
    );
  }
}
