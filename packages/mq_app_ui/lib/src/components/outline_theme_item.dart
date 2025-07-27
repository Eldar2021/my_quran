import 'package:flutter/material.dart';

class OutlineThemeItem extends StatelessWidget {
  const OutlineThemeItem({
    required this.backgroundColor,
    required this.foregroundColor,
    this.digit = 'A',
    this.borderColor = const Color(0xFF000000),
    super.key,
  });

  final Color backgroundColor;
  final Color foregroundColor;
  final String digit;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor,
      type: MaterialType.card,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
        side: BorderSide(color: borderColor),
      ),
      child: SizedBox(
        width: 70,
        height: 40,
        child: Center(
          child: Text(digit, style: TextStyle(color: foregroundColor, fontSize: 22)),
        ),
      ),
    );
  }
}
