import 'package:flutter/material.dart';
import 'package:my_quran/modules/modules.dart';

class QuranBookView extends StatefulWidget {
  const QuranBookView(this.args, {super.key});

  final QuranBookArgs args;

  static void show(BuildContext context) {
    Navigator.of(context, rootNavigator: true).push(
      MaterialPageRoute<void>(
        builder: (context) => const QuranBookView(QuranFullArgs()),
      ),
    );
  }

  @override
  State<QuranBookView> createState() => _QuranBookViewState();
}

class _QuranBookViewState extends State<QuranBookView> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
