import 'package:flutter/material.dart';
import 'package:mq_auth_repository/models/auth_model.dart';
import 'package:my_quran/modules/modules.dart';

class UserRatingMainWidget extends StatefulWidget {
  const UserRatingMainWidget(this.auth, {super.key});

  final AuthModel auth;

  @override
  State<UserRatingMainWidget> createState() => _UserRatingMainWidgetState();
}

class _UserRatingMainWidgetState extends State<UserRatingMainWidget> {
  @override
  Widget build(BuildContext context) {
    final chartData = <UserRatingMainChartData>[
      UserRatingMainChartData(DateTime.now().subtract(const Duration(days: 5)), 1, 3),
      UserRatingMainChartData(DateTime.now().subtract(const Duration(days: 6)), 3, 1),
      UserRatingMainChartData(DateTime.now().subtract(const Duration(days: 4)), 2, 2),
      UserRatingMainChartData(DateTime.now().subtract(const Duration(days: 3)), 5, 6),
      UserRatingMainChartData(DateTime.now().subtract(const Duration(days: 2)), 1, 4),
      UserRatingMainChartData(DateTime.now().subtract(const Duration(days: 1)), 2, 1),
      UserRatingMainChartData(DateTime.now(), 1, 5),
    ];
    final countryRank = 3;
    final worldRank = 492;
    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      color: Theme.of(context).colorScheme.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(
              maxHeight: 180,
              minHeight: 80,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                  bottomLeft: Radius.circular(6),
                  bottomRight: Radius.circular(6),
                ),
                child: UserRatingMainChart(chartData),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: UserRatingMainRatingTile(
              countryRank: countryRank,
              worldRank: worldRank,
              countryFlag: widget.auth.user.countryFlag,
            ),
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}
