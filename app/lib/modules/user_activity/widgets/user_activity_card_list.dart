import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:mq_auth_repository/mq_auth_repository.dart' as auth;
import 'package:my_quran/app/app.dart';
import 'package:my_quran/config/config.dart';
import 'package:my_quran/l10n/l10.dart';

class UserActivityWrapWithDescriptionList extends StatelessWidget {
  const UserActivityWrapWithDescriptionList(this.groupedData, {super.key});

  final Map<DateTime, List<auth.UserActivityModel>> groupedData;

  @override
  Widget build(BuildContext context) {
    final locale = context.read<AuthCubit>().state.currentLocale;
    return Row(
      children: [
        ...groupedData.keys.map((data) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: AvtivityMonthItemCard(
              data: data,
              activities: groupedData[data]!,
              languageCode: locale.languageCode,
            ),
          );
        }),
        Expanded(
          child: TextButton.icon(
            onPressed: () => context.pushNamed(
              AppRouter.userActivity,
              extra: groupedData,
            ),
            label: Text(context.l10n.activityDescription),
            iconAlignment: IconAlignment.end,
            icon: CircleAvatar(
              radius: 16,
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Theme.of(context).colorScheme.onPrimary,
              child: const Icon(Icons.arrow_forward_ios),
            ),
          ),
        ),
      ],
    );
  }
}

class UserActivityCardList extends StatelessWidget {
  const UserActivityCardList(this.groupedData, {super.key});

  final Map<DateTime, List<auth.UserActivityModel>> groupedData;

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

  final List<auth.UserActivityModel> activities;
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
              return AvtivityDayItemCard(activity.score);
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
  const AvtivityDayItemCard(this.score, {super.key});

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
      2 => Colors.green.shade300,
      3 => Colors.green.shade600,
      4 => Colors.green,
      _ => Colors.green,
    };
  }
}
