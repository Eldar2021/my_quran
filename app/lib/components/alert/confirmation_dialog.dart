import 'package:flutter/material.dart';
import 'package:mq_ci_keys/mq_ci_keys.dart';
import 'package:my_quran/l10n/l10.dart';

class ConfirmationWidget extends StatelessWidget {
  const ConfirmationWidget({
    required this.onPressed,
    required this.title,
    required this.content,
    super.key,
  });

  final void Function()? onPressed;
  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        style: const TextStyle(
          color: Color(0xffab4e45),
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
      content: Text(content, textAlign: TextAlign.center),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(context.l10n.no),
        ),
        TextButton(
          key: const Key(MqKeys.confirmLogoutButtonYes),
          onPressed: onPressed,
          child: Text(context.l10n.yes),
        ),
      ],
    );
  }
}
