import 'package:flutter/material.dart';
import 'package:my_quran/l10n/l10.dart';

class QuranBookSliverAdapterErrorWidget extends StatelessWidget {
  const QuranBookSliverAdapterErrorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.error,
              size: 36,
            ),
            const SizedBox(height: 16),
            Text(
              context.l10n.errorOccurred,
              textAlign: TextAlign.center,
              style: textTheme.headlineMedium,
            ),
            const SizedBox(height: 12),
            Text(
              context.l10n.errorMessage,
              textAlign: TextAlign.center,
              style: textTheme.titleMedium,
            ),
          ],
        ),
      ),
    );
  }
}
