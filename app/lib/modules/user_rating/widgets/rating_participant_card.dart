import 'package:flutter/material.dart';
import 'package:mq_app_ui/mq_app_ui.dart';
import 'package:mq_auth_repository/mq_auth_repository.dart';

class RatingParticipantCard extends StatelessWidget {
  const RatingParticipantCard(this.participant, {super.key});

  final RatingParticipantModel participant;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 8),
      leading: switch (participant.ratingNumber) {
        1 => Assets.icons.champion1.svg(),
        2 => Assets.icons.champion2.svg(),
        3 => Assets.icons.champion3.svg(),
        _ => Text(
          '${participant.ratingNumber}',
          style: theme.textTheme.titleMedium?.copyWith(color: theme.colorScheme.primary),
        ),
      },
      title: Text(participant.fullName),
      subtitle: Text(
        participant.country ?? participant.email ?? participant.userName ?? '',
      ),
      trailing: Text(
        '${participant.readedPagesCount}',
        style: theme.textTheme.titleSmall?.copyWith(color: theme.colorScheme.primary),
      ),
    );
  }
}
