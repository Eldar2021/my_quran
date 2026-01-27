import 'package:flutter/material.dart';
import 'package:mq_auth_repository/mq_auth_repository.dart';
import 'package:my_quran/modules/modules.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class UserActivityLoadingWidget extends StatelessWidget {
  const UserActivityLoadingWidget(this.groupedData, {super.key});

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
          child: Shimmer(
            colorOpacity: 0.9,
            duration: const Duration(seconds: 2),
            interval: const Duration(milliseconds: 400),
            child: UserActivityCardList(groupedData),
          ),
        ),
      ),
    );
  }
}
