import 'package:flutter/material.dart';

class MaterialCard extends StatelessWidget {
  const MaterialCard({
    required this.text,
    this.type = MaterialType.card,
    this.textColor,
    this.color,
    this.check,
    super.key,
  });

  final String text;
  final Color? color;
  final Widget? check;
  final Color? textColor;
  final MaterialType type;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: type,
      color: color,
      child: Stack(
        children: [
          Center(
            child: Text(
              text,
              style: TextStyle(color: textColor),
            ),
          ),
          if (check != null) check!,
        ],
      ),
    );
  }
}
