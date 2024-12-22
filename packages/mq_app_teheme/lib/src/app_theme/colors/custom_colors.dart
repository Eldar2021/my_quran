import 'package:flutter/material.dart';

enum TargetColor {
  red(Colors.red, 0),
  yellow(Colors.yellow, 1),
  green(Colors.green, 2),
  blue(Colors.blue, 3),
  purple(Colors.purple, 4),
  deepOrange(Colors.deepOrange, 5),
  brown(Colors.brown, 6);

  const TargetColor(this.color, this.caheIindex);

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

  // String displayName(BuildContext context) {
  //   return switch (this) {
  //     TargetColor.red => context.l10n.colorRed,
  //     TargetColor.yellow => context.l10n.colorYellow,
  //     TargetColor.green => context.l10n.colorGreen,
  //     TargetColor.blue => context.l10n.colorBlue,
  //     TargetColor.purple => context.l10n.colorPurple,
  //     TargetColor.brown => context.l10n.colorBrown,
  //     TargetColor.deepOrange => context.l10n.colorOrange,
  //   };
  // }

  final Color color;
  final int caheIindex;
}
