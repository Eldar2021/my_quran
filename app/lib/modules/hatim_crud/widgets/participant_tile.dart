import 'package:flutter/material.dart';
import 'package:mq_app_ui/mq_app_ui.dart';
import 'package:mq_hatim_repository/mq_hatim_repository.dart';

class ParticipantTile extends StatelessWidget {
  const ParticipantTile({
    required this.user,
    required this.onPressed,
    required this.text,
    this.isOutlined = false,
    super.key,
  });

  final MqUserIdModel user;
  final String text;
  final void Function()? onPressed;
  final bool isOutlined;

  @override
  Widget build(BuildContext context) {
    final prTextTheme = Theme.of(context).primaryTextTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        backgroundColor: colorScheme.onSurface.withValues(alpha: 0.1),
        child: Assets.icons.userMale.svg(
          colorFilter: ColorFilter.mode(
            colorScheme.onSurface,
            BlendMode.srcIn,
          ),
        ),
      ),
      title: Text(
        '${user.firstName} ${user.lastName}',
        overflow: TextOverflow.ellipsis,
        style: prTextTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w400,
        ),
      ),
      subtitle: Text(
        '${user.userName}',
        overflow: TextOverflow.ellipsis,
        style: prTextTheme.titleSmall?.copyWith(
          fontWeight: FontWeight.w400,
        ),
      ),
      trailing: isOutlined
          ? OutlinedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(118, 36),
              ),
              onPressed: onPressed,
              child: Text(text),
            )
          : ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(130, 36),
              ),
              onPressed: onPressed,
              child: Text(text),
            ),
    );
  }
}
