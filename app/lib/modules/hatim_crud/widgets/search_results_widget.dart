import 'package:flutter/material.dart';
import 'package:mq_hatim_repository/mq_hatim_repository.dart';
import 'package:my_quran/l10n/l10.dart';
import 'package:my_quran/modules/modules.dart';

class SearchResultsWidget extends StatelessWidget {
  const SearchResultsWidget({
    required this.users,
    required this.onAddParticipant,
    super.key,
  });

  final Set<MqUserIdModel> users;
  final void Function(MqUserIdModel user) onAddParticipant;

  @override
  Widget build(BuildContext context) {
    if (users.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 180),
          child: Text(context.l10n.noUsersFound),
        ),
      );
    }
    return ListView.separated(
      itemCount: users.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      separatorBuilder: (context, index) => const Divider(),
      itemBuilder: (context, index) {
        final user = users.elementAt(index);
        return ParticipantTile(
          user: user,
          buttonText: context.l10n.add,
          onPressed: () => onAddParticipant(user),
        );
      },
    );
  }
}
