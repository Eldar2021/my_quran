import 'package:flutter/material.dart';

class QuranBookSliverProgressingIndicator extends StatelessWidget {
  const QuranBookSliverProgressingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.only(top: 50),
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
