import 'package:flutter/material.dart';
import 'package:my_quran/l10n/l10.dart';

class UserRatingMainRatingTile extends StatelessWidget {
  const UserRatingMainRatingTile({
    required this.worldRank,
    this.countryRank,
    this.countryFlag,
    super.key,
  });

  final int? countryRank;
  final String? countryFlag;
  final int worldRank;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            '${context.l10n.yourRating}:  $ratingText',
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        Icon(
          Icons.arrow_forward_ios,
          size: 18,
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ],
    );
  }

  String get ratingText {
    if (countryRank != null && countryFlag != null) {
      return '$countryFlag #$countryRank | 🌍 #$worldRank';
    }
    return '🌍 #$worldRank';
  }
}
