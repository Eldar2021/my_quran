import 'package:flutter/material.dart';
import 'package:my_quran/l10n/l10.dart';
import 'package:my_quran/modules/modules.dart';

class QuranAmenDialogBody extends StatelessWidget {
  const QuranAmenDialogBody(this.args, {super.key});

  final QuranAmenDialogContentArgs args;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          context.l10n.dua,
          textAlign: TextAlign.center,
          style: textTheme.titleLarge?.copyWith(
            color: args.readThemeState.frColor,
          ),
        ),
        const SizedBox(height: 16),
        Icon(
          Icons.info,
          color: args.readThemeState.frColor,
        ),
        const SizedBox(height: 6),
        Text(
          args.confirmMessage,
          textAlign: TextAlign.center,
          style: textTheme.labelMedium?.copyWith(
            color: args.readThemeState.frColor,
          ),
        ),
      ],
    );
  }
}
