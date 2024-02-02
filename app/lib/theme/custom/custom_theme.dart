import 'package:flutter/material.dart';
import 'package:my_quran/theme/theme.dart';

class CustomTheme with CompomnentTheme {
  const CustomTheme(this.brightness, this.targetColor);

  final Brightness brightness;
  final Color targetColor;

  @override
  ColorScheme get scheme => ColorScheme.fromSeed(
      seedColor: targetColor,
      brightness: brightness,
    );

  ThemeData get _base {
    return ThemeData(
      colorScheme: scheme,
      appBarTheme: appBarTheme(scheme),
      cardTheme: cardTheme(),
      listTileTheme: listTileTheme(scheme),
      bottomAppBarTheme: bottomAppBarTheme(scheme),
      bottomNavigationBarTheme: bottomNavigationBarTheme(scheme),
      navigationRailTheme: navigationRailTheme(scheme),
      tabBarTheme: tabBarTheme(scheme),
      drawerTheme: drawerTheme(scheme),
      buttonTheme: buttonTheme(scheme),
      inputDecorationTheme: inputDecorationTheme(scheme),
      elevatedButtonTheme: elevatedButtonThemeData(scheme),
      scrollbarTheme: scrollbarThemeData(scheme),
    );
  }

  ThemeData get light {
    return _base.copyWith(
      brightness: Brightness.light
    );
  }

  ThemeData get dark {
    return _base.copyWith(
      brightness: Brightness.dart
    );
  }

  ThemeData get themeData => brightness == Brightness.dark ? dark : light;

  CustomTheme copyWith({Brightness? brightness, Color? targetColor}) {
    return CustomTheme(brightness ?? this.brightness, targetColor ?? this.targetColor);
  }
}
