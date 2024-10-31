import 'package:flutter/material.dart';

class MaterialCard extends StatelessWidget {
  const MaterialCard({
    required this.color,
    required this.text,
    required this.textColor,
    this.check,
    super.key,
  });

  final Color color;
  final String text;
  final Widget? check;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.circle,
      color: color,
      child: Stack(
        children: [
          Center(child: Text(text, style: TextStyle(color: textColor))),
          if (check != null) check!,
        ],
      ),
    );
  }
}
