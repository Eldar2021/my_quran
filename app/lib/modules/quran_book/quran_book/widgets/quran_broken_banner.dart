import 'package:flutter/material.dart';
import 'package:my_quran/l10n/l10.dart';

class QuranBrokenBanner extends StatelessWidget {
  const QuranBrokenBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(color: colorScheme.error),
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListTile(
          leading: Icon(
            Icons.error_outline,
            color: colorScheme.error,
          ),
          title: Text(
            context.l10n.fontErrorMessage,
            style: textTheme.bodyMedium?.copyWith(color: colorScheme.error),
          ),
        ),
      ),
    );
  }
}
