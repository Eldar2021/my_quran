import 'package:flutter/material.dart';
import 'package:mq_hatim_repository/mq_hatim_repository.dart';

class ParticipantTile extends StatelessWidget {
  const ParticipantTile({
    required this.user,
    required this.onPressed,
    required this.buttonText,
    this.isRemove = false,
    super.key,
  });

  final MqUserIdModel user;
  final String buttonText;
  final void Function()? onPressed;
  final bool isRemove;

  @override
  Widget build(BuildContext context) {
    final prTextTheme = Theme.of(context).primaryTextTheme;
    final colors = Theme.of(context).colorScheme;
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        radius: 24,
        backgroundColor: colors.surfaceBright,
        child: Text(
          user.uiTitle[0].toUpperCase(),
          style: prTextTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      title: Text(
        user.uiTitle,
        style: prTextTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w400,
        ),
      ),
      subtitle: Text(
        user.uiSubtitle,
        style: prTextTheme.titleSmall?.copyWith(
          fontWeight: FontWeight.w400,
        ),
      ),
      trailing: isRemove
          ? IconButton.outlined(
              onPressed: onPressed,
              style: ButtonStyle(
                side: WidgetStateProperty.all(
                  BorderSide(color: colors.primary, width: 2),
                ),
              ),
              icon: Icon(
                Icons.remove,
                color: colors.primary,
              ),
            )
          : IconButton.filled(
              onPressed: onPressed,
              icon: Icon(
                Icons.add,
                color: colors.onPrimary,
              ),
            ),
    );
  }
}
