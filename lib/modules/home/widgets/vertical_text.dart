import 'package:flutter/material.dart';

class VerticalText extends StatelessWidget {
  const VerticalText(this.text, this.value, {super.key});

  final String text;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          const SizedBox(height: 8),
          Text(text, overflow: TextOverflow.ellipsis),
          const SizedBox(height: 4),
          Text(value),
        ],
      ),
    );
  }
}
