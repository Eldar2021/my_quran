import 'package:flutter/widgets.dart';
import 'package:my_quran/modules/modules.dart';

class QuranBookView extends StatefulWidget {
  const QuranBookView({
    required this.args,
    super.key,
  });

  final QuranBookArgs args;

  @override
  State<QuranBookView> createState() => _QuranBookViewState();
}

class _QuranBookViewState extends State<QuranBookView> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
