import 'package:flutter/material.dart';
import 'package:mq_auth_repository/mq_auth_repository.dart';
import 'package:my_quran/modules/modules.dart';

class UserActivityLoadedWidget extends StatelessWidget {
  const UserActivityLoadedWidget(this.groupedData, {super.key});

  final Map<DateTime, List<UserActivityModel>> groupedData;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 145,
      width: double.infinity,
      child: Card.outlined(
        margin: EdgeInsets.zero,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: UserActivityCardList(groupedData),
        ),
      ),
    );
  }
}
