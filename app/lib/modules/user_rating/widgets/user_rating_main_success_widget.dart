import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mq_auth_repository/mq_auth_repository.dart';
import 'package:my_quran/config/config.dart';
import 'package:my_quran/modules/modules.dart';

class UserRatingMainSuccessWidget extends StatelessWidget {
  const UserRatingMainSuccessWidget({
    required this.data,
    this.countryFlag,
    super.key,
  });

  final UserRatingMainModel data;
  final String? countryFlag;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      color: Theme.of(context).colorScheme.surface,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => context.pushNamed(AppRouter.userRating),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: data.dataIsBad ? 100 : 180,
                minHeight: 100,
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
                  child: UserRatingMainChart(
                    data.weeklyData
                        .map(
                          (e) => UserRatingMainChartData(
                            e.date,
                            e.readedPagesCount,
                            e.listenedQuranByHours,
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: UserRatingMainRatingTile(
                countryRank: data.countryRank,
                worldRank: data.worldRank,
                countryFlag: countryFlag,
              ),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
