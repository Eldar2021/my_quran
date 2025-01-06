import 'package:flutter/material.dart';
import 'package:mq_app_ui/mq_app_ui.dart';

abstract class MqAlertDialogs {
  static Future<T?> showAmen<T>({
    required BuildContext context,
    MqAppUiGender gender = MqAppUiGender.male,
    String title = 'Amen',
    String buttonText = 'Amen',
    bool barrierDismissible = true,
    String? content,
    void Function()? onPressed,
  }) {
    return showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) {
        final colorScheme = Theme.of(context).colorScheme;
        return AlertDialog(
          backgroundColor: colorScheme.surface,
          actionsAlignment: MainAxisAlignment.center,
          icon: switch (gender) {
            MqAppUiGender.male => Assets.icons.userMale.svg(
                height: 100,
                colorFilter: ColorFilter.mode(
                  colorScheme.onSurface,
                  BlendMode.srcIn,
                ),
              ),
            MqAppUiGender.famale => Assets.icons.userFemale.svg(
                height: 100,
                colorFilter: ColorFilter.mode(
                  colorScheme.onSurface,
                  BlendMode.srcIn,
                ),
              ),
            MqAppUiGender.unknown => Assets.icons.moonIslamic.svg(
                height: 100,
                colorFilter: ColorFilter.mode(
                  colorScheme.onSurface,
                  BlendMode.srcIn,
                ),
              ),
          },
          title: Text(title),
          content: content != null ? Text(content, textAlign: TextAlign.center) : null,
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(double.maxFinite, 52),
              ),
              onPressed: onPressed,
              child: Text(buttonText),
            ),
          ],
        );
      },
    );
  }
}
