import 'package:flutter/material.dart';
import 'package:mq_app_ui/mq_app_ui.dart';

abstract class MqAlertDialogs {
  static Future<T?> showAmen<T>({
    required BuildContext context,
    required Color backgroundColor,
    required Color foregroundColor,
    MqAppUiGender gender = MqAppUiGender.male,
    String title = 'Amen',
    String buttonText = 'Amen',
    bool barrierDismissible = true,
    String? content,
    void Function()? onPressed,
  }) {
    final textTheme = Theme.of(context).textTheme;
    return showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) {
        return AlertDialog(
          backgroundColor: backgroundColor,
          contentTextStyle: textTheme.titleMedium?.copyWith(color: foregroundColor),
          titleTextStyle: textTheme.titleLarge?.copyWith(color: foregroundColor),
          actionsAlignment: MainAxisAlignment.center,
          icon: switch (gender) {
            MqAppUiGender.male => Assets.icons.userMale.svg(
              height: 100,
              colorFilter: ColorFilter.mode(foregroundColor, BlendMode.srcIn),
            ),
            MqAppUiGender.famale => Assets.icons.userFemale.svg(
              height: 100,
              colorFilter: ColorFilter.mode(foregroundColor, BlendMode.srcIn),
            ),
            MqAppUiGender.unknown => Assets.icons.moonIslamic.svg(
              height: 100,
              colorFilter: ColorFilter.mode(foregroundColor, BlendMode.srcIn),
            ),
          },
          title: Text(title),
          content: content != null ? Text(content, textAlign: TextAlign.center) : null,
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(fixedSize: const Size(double.maxFinite, 52)),
              onPressed: onPressed,
              child: Text(buttonText),
            ),
          ],
        );
      },
    );
  }
}
