import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mq_auth_repository/mq_auth_repository.dart';
import 'package:my_quran/modules/modules.dart';

class UserActivityCard extends StatefulWidget {
  const UserActivityCard({super.key});

  @override
  State<UserActivityCard> createState() => _UserActivityCardState();
}

class _UserActivityCardState extends State<UserActivityCard> {
  late final List<UserActivityModel> defaultActivities;

  @override
  void initState() {
    defaultActivities = AuthRepositoryMock.generateMockActivities(
      DateTime.now(),
      180,
      (i) => false,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserActivityCubit, UserActivityState>(
      builder: (context, state) {
        return switch (state) {
          UserActivityInitial() => UserActivityLoadingWidget(groupByMonth(defaultActivities)),
          UserActivityLoading() => UserActivityLoadingWidget(groupByMonth(defaultActivities)),
          UserActivityLoaded() => UserActivityLoadedWidget(groupByMonth(state.activities)),
          UserActivityUnauthorized() => UserActivityUnauthorizedWidget(groupByMonth(defaultActivities)),
          UserActivityError() => const UserActivityErrorWidget(),
        };
      },
    );
  }

  Map<DateTime, List<UserActivityModel>> groupByMonth(List<UserActivityModel> activities) {
    final grouped = <DateTime, List<UserActivityModel>>{};
    for (final activity in activities) {
      final month = DateTime(activity.date.year, activity.date.month);
      if (!grouped.containsKey(month)) {
        grouped[month] = [];
      }
      grouped[month]!.add(activity);
    }
    return grouped;
  }
}
