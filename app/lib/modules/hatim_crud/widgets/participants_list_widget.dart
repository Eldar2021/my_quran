import 'package:flutter/material.dart';
import 'package:mq_hatim_repository/mq_hatim_repository.dart';
import 'package:my_quran/l10n/l10.dart';
import 'package:my_quran/modules/modules.dart';

class ParticipantsListWidget extends StatelessWidget {
  const ParticipantsListWidget({
    required this.participants,
    required this.onRemoveParticipant,
    super.key,
  });

  final List<MqUserIdModel> participants;
  final void Function(MqUserIdModel user) onRemoveParticipant;

  @override
  Widget build(BuildContext context) {
    final prTextTheme = Theme.of(context).primaryTextTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 20),
        Text(
          context.l10n.addedParticipants,
          style: prTextTheme.titleMedium,
        ),
        const SizedBox(height: 10),
        ListView.separated(
          itemCount: participants.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.only(bottom: 10),
          separatorBuilder: (context, index) => const Divider(),
          itemBuilder: (context, index) {
            final user = participants[index];
            return ParticipantTile(
              user: user,
              buttonText: context.l10n.remove,
              isRemove: true,
              onPressed: () => onRemoveParticipant(user),
            );
          },
        ),
      ],
    );
  }
}
