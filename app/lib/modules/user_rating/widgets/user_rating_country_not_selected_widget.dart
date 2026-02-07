import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_quran/config/config.dart';
import 'package:my_quran/l10n/l10.dart';

class UserRatingCountryNotSelectedWidget extends StatelessWidget {
  const UserRatingCountryNotSelectedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final prTextTheme = Theme.of(context).primaryTextTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            context.l10n.countryNotSelected,
            style: prTextTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            context.l10n.ratingCountryPrompt,
            style: prTextTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          TextButton(
            onPressed: () => context.pushReplacementNamed(AppRouter.profile),
            child: Text(context.l10n.selectCountry),
          ),
        ],
      ),
    );
  }
}
