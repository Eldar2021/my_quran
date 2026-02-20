import 'package:flutter/material.dart';
import 'package:my_quran/l10n/l10.dart';

class QuranAmenDialogTitle extends StatelessWidget {
  const QuranAmenDialogTitle(this.color, {super.key});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text(
      context.l10n.amen,
      style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: color),
    );
  }
}
