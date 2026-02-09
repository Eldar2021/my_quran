import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mq_auth_repository/mq_auth_repository.dart' as auth;

class ActivityMonthItemCard extends StatelessWidget {
  const ActivityMonthItemCard({
    required this.activities,
    required this.data,
    required this.languageCode,
    required this.enabledTooltip,
    super.key,
  });

  final List<auth.UserActivityModel> activities;
  final DateTime data;
  final String languageCode;
  final bool enabledTooltip;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          _formatMonthByNumber(data.month),
        ),
        const SizedBox(height: 4),
        Expanded(
          child: Wrap(
            direction: Axis.vertical,
            spacing: 3,
            runSpacing: 3,
            children: activities.map((activity) {
              if (enabledTooltip) {
                return Tooltip(
                  triggerMode: TooltipTriggerMode.tap,
                  message: DateFormat.MMMMd(languageCode).format(activity.date),
                  child: ActivityDayItemCard(activity.score),
                );
              } else {
                return ActivityDayItemCard(activity.score);
              }
            }).toList(),
          ),
        ),
      ],
    );
  }

  String _formatMonthByNumber(int i) {
    final date = DateTime(DateTime.now().year, i);
    return DateFormat('MMM', languageCode).format(date);
  }
}

class ActivityDayItemCard extends StatelessWidget {
  const ActivityDayItemCard(this.score, {super.key});

  final int score;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: _getBoxColor(score, context),
        borderRadius: BorderRadius.circular(2),
        border: Border.all(color: _getBoxColor(score, context)),
      ),
      child: const SizedBox(width: 12, height: 12),
    );
  }

  Color _getBoxColor(int score, BuildContext context) {
    return switch (score) {
      0 => switch (Theme.of(context).brightness) {
        Brightness.light => const Color(0xffEFF2F5),
        Brightness.dark => const Color.fromARGB(255, 34, 40, 47),
      },
      1 => Colors.green.shade100,
      2 => Colors.green.shade200,
      3 => Colors.green,
      _ => Colors.green,
    };
  }
}
