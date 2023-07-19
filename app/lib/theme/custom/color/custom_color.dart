import 'package:flutter/material.dart';

enum TargetColor {
  red(Colors.red, 0, 'Red'),
  yellow(Colors.yellow, 1, 'yellow'),
  green(Colors.green, 2, 'green'),
  blue(Colors.blue, 3, 'blue'),
  purple(Colors.purple, 4, 'purple'),
  deepOrange(Colors.deepOrange, 5, 'deepOrange'),
  brown(Colors.brown, 6, 'brown');

  const TargetColor(this.color, this.caheIindex, this.displayName);

  factory TargetColor.fromIndex(int index) {
    return switch (index) {
      0 => TargetColor.red,
      1 => TargetColor.yellow,
      2 => TargetColor.green,
      3 => TargetColor.blue,
      4 => TargetColor.purple,
      5 => TargetColor.deepOrange,
      6 => TargetColor.brown,
      _ => TargetColor.red,
    };
  }

  final Color color;
  final int caheIindex;
  final String displayName;
}
