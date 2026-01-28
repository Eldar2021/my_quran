import 'package:flutter/material.dart';
import 'package:mq_auth_repository/mq_auth_repository.dart';
import 'package:my_quran/l10n/l10.dart';
import 'package:my_quran/modules/modules.dart';
import 'package:my_quran/modules/user_activity/widgets/user_activity_detail_card.dart';

class UserActivityView extends StatelessWidget {
  const UserActivityView(this.data, {super.key});

  final Map<DateTime, List<UserActivityModel>> data;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: colorScheme.surfaceContainerLow,
      appBar: AppBar(
        backgroundColor: colorScheme.surfaceContainerLow,
        title: Text(context.l10n.userActivity),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          const SizedBox(height: 16),
          UserActivityLoadedWidget(data),
          const SizedBox(height: 24),
          UserActivityDetailCard(data),
        ],
      ),
    );
  }
}
