import 'package:flutter/material.dart';

class MaterialCard extends StatelessWidget {
  const MaterialCard({
    required this.text,
    required this.textColor,
    this.check,
    super.key,
  });

  final String text;
  final Widget? check;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.circle,
      color: Colors.white,
      child: Stack(
        children: [
          Center(child: Text(text, style: TextStyle(color: textColor))),
          if (check != null) check!,
        ],
      ),
    );
  }
}
