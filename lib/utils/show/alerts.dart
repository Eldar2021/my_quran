import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatim/app/app.dart';

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

  static Future<T?> showAmin<T>(BuildContext context, Gender gender, {bool isHatim = false, required int totalPages}) {
    final colorScheme = Theme.of(context).colorScheme;
    return showDialog<T>(
      context: context,
      builder: (context) {
        return AlertDialog(
          icon: gender == Gender.male
              ? Assets.icons.duaMale.svg(height: 70, color: colorScheme.onBackground)
              : Assets.icons.duaFemale.svg(height: 70),
          title: Text(context.l10n.amin),
          content: Text(context.l10n.aminDua, textAlign: TextAlign.center),
          actions: [
            CustomButton(
              text: context.l10n.amin,
              onPressed: () async {
                if (isHatim) {
                  //Navigator.popUntil(context, (route) => false);
                }
                await context.read<AuthCubit>().setTotalRead(totalPages);
                // ignore: use_build_context_synchronously
                Navigator.popUntil(context, (route) => route.isFirst);
              },
            )
          ],
        );
      },
    );
  }
}
