import 'package:flutter/material.dart';
import 'package:hatim/theme/custom/custom_theme.dart';


class CustomColor {
  const CustomColor({
    required this.name,
    required this.color,
    this.blend = true,
  });

  final String name;
  final Color color;
  final bool blend;

  Color value(CustomTheme theme) {
    return theme.custom(this);
  }
}
