import 'package:flutter/material.dart';
import 'package:my_quran/modules/modules.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class UserRatingMainLoadingWidget extends StatelessWidget {
  const UserRatingMainLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      colorOpacity: 1,
      child: Card(
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
                  child: UserRatingMainChart(
                    List.generate(
                      7,
                      (index) => UserRatingMainChartData(
                        DateTime.now().subtract(Duration(days: index)),
                        4,
                        4,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: UserRatingMainRatingTile(
                countryRank: 0,
                worldRank: 0,
              ),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
