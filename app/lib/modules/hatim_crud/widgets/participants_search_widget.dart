import 'package:flutter/material.dart';
import 'package:mq_hatim_repository/mq_hatim_repository.dart';
import 'package:my_quran/l10n/l10.dart';
import 'package:my_quran/modules/modules.dart';

class ParticipantsSearchWidget extends StatelessWidget {
  const ParticipantsSearchWidget({
    required this.state,
    required this.participants,
    required this.onAddParticipant,
    super.key,
  });

  final HatimCrudParticipantsSearchState state;
  final List<MqUserIdModel> participants;
  final void Function(MqUserIdModel user) onAddParticipant;

  @override
  Widget build(BuildContext context) {
    return switch (state) {
      HatimCrudParticipantsSearchInitial() => const SizedBox.shrink(),
      HatimCrudParticipantsSearchLoading() => const Center(
        child: CircularProgressIndicator.adaptive(),
      ),
      HatimCrudParticipantsSearchSuccess(data: final data) => SearchResultsWidget(
        users: (data?.users ?? []).toSet(),
        onAddParticipant: onAddParticipant,
      ),
      HatimCrudParticipantsSearchError() => Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 180),
          child: Text(context.l10n.noUsersFound),
        ),
      ),
    };
  }
}
