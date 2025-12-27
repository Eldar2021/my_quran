import 'package:flutter/material.dart';
import 'package:mq_app_ui/mq_app_ui.dart';
import 'package:mq_auth_repository/mq_auth_repository.dart';
import 'package:my_quran/l10n/l10.dart';

class UserProfileUnauthenticatedCard extends StatelessWidget {
  const UserProfileUnauthenticatedCard({
    required this.gender,
    this.onTap,
    super.key,
  });

  final Gender gender;
  final VoidCallback? onTap;

  static const _avatarRadius = 28.0;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      color: colorScheme.surface,
      child: ListTile(
        contentPadding: const EdgeInsets.all(8),
        onTap: onTap,
        title: Text(context.l10n.guest),
        subtitle: Text(context.l10n.authMessage),
        trailing: const Icon(Icons.arrow_forward_ios),
        leading: CircleAvatar(
          radius: _avatarRadius,
          backgroundColor: colorScheme.surfaceContainerLow,
          child: switch (gender) {
            Gender.male => Assets.icons.userMale.svg(
              colorFilter: ColorFilter.mode(
                colorScheme.onSurface,
                BlendMode.srcIn,
              ),
            ),
            Gender.female => Assets.icons.userFemale.svg(
              colorFilter: ColorFilter.mode(
                colorScheme.onSurface,
                BlendMode.srcIn,
              ),
            ),
          },
        ),
      ),
    );
  }
}
