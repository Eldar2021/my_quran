import 'package:flutter/material.dart';
import 'package:mq_ci_keys/mq_ci_keys.dart';
import 'package:my_quran/l10n/l10.dart';

class ConfirmationWidget extends StatelessWidget {
  const ConfirmationWidget({
    required this.onPressed,
    super.key,
  });

  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(child: Text(context.l10n.logout)),
      content: Text(context.l10n.signOutContext),
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
