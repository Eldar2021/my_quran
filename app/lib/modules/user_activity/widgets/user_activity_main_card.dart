import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:my_quran/app/cubit/auth_cubit.dart';
import 'package:my_quran/modules/user_activity/user_activity.dart';

class UserActivityMainCard extends StatefulWidget {
  const UserActivityMainCard({super.key});

  @override
  State<UserActivityMainCard> createState() => _UserActivityMainCardState();
}

class _UserActivityMainCardState extends State<UserActivityMainCard> {
  late final List<DayActivity> _model;
  late final Map<DateTime, List<DayActivity>> _groupedData;

  @override
  void initState() {
    _model = DayActivity.generateMockData();
    final data = DayActivity.fillYearlyData(_model);
    _groupedData = DayActivity.groupByMonth(data);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final locale = context.read<AuthCubit>().state.currentLocale;
    return SizedBox(
      height: 145,
      width: double.infinity,
      child: Card.outlined(
        margin: EdgeInsets.zero,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: _groupedData.length,
            separatorBuilder: (context, index) => const SizedBox(width: 8),
            itemBuilder: (context, index) {
              final data = _groupedData.keys.elementAt(index);
              final activities = _groupedData[data]!;
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    _formatMonthByNumber(data.month, locale.languageCode),
                  ),
                  const SizedBox(height: 4),
                  Expanded(
                    child: Wrap(
                      direction: Axis.vertical,
                      spacing: 3,
                      runSpacing: 3,
                      children: activities.map((activity) {
                        final score = activity.score;
                        return Tooltip(
                          triggerMode: TooltipTriggerMode.tap,
                          message: '${DateFormat.yMMMd(locale.languageCode).format(activity.date)}\nScore: $score',
                          child: Container(
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                              color: _getBoxColor(score),
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  String _formatMonthByNumber(int i, String locale) {
    final date = DateTime(DateTime.now().year, i);
    return DateFormat('MMM').format(date);
  }

  Color _getBoxColor(int score) {
    return switch (score) {
      0 => Colors.green.shade50,
      1 => Colors.green.shade100,
      2 => Colors.green.shade300,
      3 => Colors.green.shade400,
      4 => Colors.green.shade500,
      5 => Colors.green.shade600,
      6 => Colors.green.shade700,
      7 => Colors.green.shade800,
      8 => Colors.green.shade900,
      _ => Colors.grey,
    };
  }
}
