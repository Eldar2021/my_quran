import 'package:flutter/material.dart';
import 'package:my_quran/l10n/l10.dart';

class QuranBookSliverAmenButton extends StatelessWidget {
  const QuranBookSliverAmenButton({
    required this.onAmenPressed,
    super.key,
  });

  final void Function() onAmenPressed;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(
          top: 50,
          bottom: 50,
          left: 24,
          right: 24,
        ),
        child: ElevatedButton(
          onPressed: onAmenPressed,
          child: Text(context.l10n.readed),
        ),
      ),
    );
  }
}
