import 'package:flutter/material.dart';

class ColorTextAppHint extends StatelessWidget {
  const ColorTextAppHint({
    required this.color,
    required this.hintText,
    super.key,
  });

  final Color color;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 20,
          height: 20,
          child: Material(type: MaterialType.card, color: color),
        ),
        const SizedBox(width: 14),
        Expanded(child: Text(hintText, maxLines: 3)),
      ],
    );
  }
}
