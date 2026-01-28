import 'package:flutter/material.dart';
import 'package:mq_auth_repository/mq_auth_repository.dart';
import 'package:my_quran/l10n/l10.dart';
import 'package:my_quran/modules/modules.dart';

class UserActivityView extends StatefulWidget {
  const UserActivityView(this.data, {super.key});

  final Map<DateTime, List<UserActivityModel>> data;

  @override
  State<UserActivityView> createState() => _UserActivityViewState();
}

class _UserActivityViewState extends State<UserActivityView> {
  late final Map<DateTime, List<UserActivityModel>> _filteredActivities;

  @override
  void initState() {
    _filteredActivities = _prepareActivities();
    super.initState();
  }

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
          UserActivityLoadedWidget(widget.data),
          const SizedBox(height: 24),
          UserActivityDetailCard(_filteredActivities),
        ],
      ),
    );
  }

  Map<DateTime, List<UserActivityModel>> _prepareActivities() {
    final now = DateTime.now();
    return Map.fromEntries(
      widget.data.entries
          .where(
            (e) => e.key.isBefore(
              now.add(const Duration(days: 1)),
            ),
          )
          .toList()
        ..sort((a, b) => a.key.compareTo(b.key)),
    );
  }
}
