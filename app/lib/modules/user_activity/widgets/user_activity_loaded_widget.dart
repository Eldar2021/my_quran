import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mq_auth_repository/mq_auth_repository.dart';
import 'package:my_quran/config/config.dart';
import 'package:my_quran/modules/modules.dart';

class UserActivityLoadedWidget extends StatelessWidget {
  const UserActivityLoadedWidget(
    this.groupedData, {
    super.key,
    this.isShowDescription = false,
  });

  final Map<DateTime, List<UserActivityModel>> groupedData;
  final bool isShowDescription;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 145,
      width: double.infinity,
      child: Card.outlined(
        margin: EdgeInsets.zero,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: InkWell(
            onTap: () => context.pushNamed(
              AppRouter.userActivity,
              extra: groupedData,
            ),
            child: UserActivityCardList(groupedData),
          ),
        ),
      ),
    );
  }
}
