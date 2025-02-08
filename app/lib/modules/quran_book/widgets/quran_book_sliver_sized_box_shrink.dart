import 'package:flutter/material.dart';

class QuranBookSliverSizedBoxShrink extends StatelessWidget {
  const QuranBookSliverSizedBoxShrink({super.key});

  @override
  Widget build(BuildContext context) {
    return const SliverToBoxAdapter(
      child: SizedBox.shrink(),
    );
  }
}
