import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mq_auth_repository/mq_auth_repository.dart';
import 'package:my_quran/app/app.dart';

class UserActivityCardList extends StatelessWidget {
  const UserActivityCardList(this.groupedData, {super.key});

  final Map<DateTime, List<UserActivityModel>> groupedData;

  @override
  Widget build(BuildContext context) {
    final locale = context.read<AuthCubit>().state.currentLocale;
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: groupedData.length,
      separatorBuilder: (context, index) => const SizedBox(width: 8),
      itemBuilder: (context, index) {
        final data = groupedData.keys.elementAt(index);
        return AvtivityMonthItemCard(
          data: data,
          activities: groupedData[data]!,
          languageCode: locale.languageCode,
        );
      },
    );
  }
}

class AvtivityMonthItemCard extends StatelessWidget {
  const AvtivityMonthItemCard({
    required this.activities,
    required this.data,
    required this.languageCode,
    super.key,
  });

  final List<UserActivityModel> activities;
  final DateTime data;
  final String languageCode;

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
              final score = activity.score;
              return AvtivityDayItemCard(
                score: score,
                message: DateFormat.yMMMd(languageCode).format(activity.date),
              );
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

class AvtivityDayItemCard extends StatelessWidget {
  const AvtivityDayItemCard({
    required this.score,
    required this.message,
    super.key,
  });

  final int score;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      triggerMode: TooltipTriggerMode.tap,
      message: message,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: _getBoxColor(score, context),
          borderRadius: BorderRadius.circular(2),
          border: Border.all(color: _getBoxColor(score, context)),
        ),
        child: const SizedBox(width: 12, height: 12),
      ),
    );
  }

  Color _getBoxColor(int score, BuildContext context) {
    return switch (score) {
      0 => switch (Theme.of(context).brightness) {
        Brightness.light => const Color(0xffEFF2F5),
        Brightness.dark => const Color.fromARGB(255, 34, 40, 47),
      },
      1 => Colors.green.shade100,
      2 => Colors.green.shade300,
      3 => Colors.green.shade600,
      4 => Colors.green,
      _ => Colors.green,
    };
  }
}
