import 'package:flutter/material.dart';
import 'package:my_quran/l10n/l10.dart';
import 'package:my_quran/modules/modules.dart';

class UserActivityInfoDetailCard extends StatelessWidget {
  const UserActivityInfoDetailCard({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      color: colorScheme.surface,
      child: Column(
        children: [
          const SizedBox(height: 4),
          TextButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.info),
            label: Text(context.l10n.activityDescription),
          ),
          const SizedBox(height: 4),
          _InFoField(
            title: context.l10n.noActivityDay,
            score: 0,
          ),
          _InFoField(
            title: context.l10n.openedOnceDay,
            score: 1,
          ),
          _InFoField(
            title: context.l10n.readQuranActivity,
            score: 2,
          ),
          _InFoField(
            title: context.l10n.listenQuranActivity,
            score: 4,
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

class _InFoField extends StatelessWidget {
  const _InFoField({
    required this.title,
    required this.score,
  });

  final String title;
  final int score;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              '- $title',
              style: textTheme.titleSmall,
            ),
          ),
          AvtivityDayItemCard(score),
        ],
      ),
    );
  }
}
