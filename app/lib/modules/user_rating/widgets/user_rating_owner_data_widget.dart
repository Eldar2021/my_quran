import 'package:flutter/material.dart';
import 'package:mq_app_ui/mq_app_ui.dart';
import 'package:mq_auth_repository/mq_auth_repository.dart';
import 'package:my_quran/l10n/l10.dart';

class UserRatingOwnerDataWidget extends StatelessWidget {
  const UserRatingOwnerDataWidget({
    required this.ownerData,
    required this.user,
    super.key,
  });

  final RatingOwnerModel ownerData;
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
      leading: switch (ownerData.ratingNumber) {
        1 => Assets.icons.champion1.svg(),
        2 => Assets.icons.champion2.svg(),
        3 => Assets.icons.champion3.svg(),
        _ => Text(
          '${ownerData.ratingNumber}',
          style: theme.textTheme.titleMedium?.copyWith(color: theme.colorScheme.primary),
        ),
      },
      title: Text(user.fullName ?? context.l10n.noName),
      subtitle: Text(user.username ?? context.l10n.noUsername),
      trailing: Text(
        '${ownerData.readedPagesCount}',
        style: theme.textTheme.titleSmall?.copyWith(color: theme.colorScheme.primary),
      ),
    );
  }
}
