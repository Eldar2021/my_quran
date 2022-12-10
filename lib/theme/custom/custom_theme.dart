import 'package:flutter/material.dart';
import 'package:hatim/theme/theme.dart';

class CustomTheme with CompomnentTheme {
  const CustomTheme(this.brightness, this.targetColor);

  final Brightness brightness;
  final Color targetColor;

  ColorScheme colors() {
    return ColorScheme.fromSeed(
      seedColor: targetColor,
      brightness: brightness,
    );
  }

  ThemeData light() {
    final scheme = colors();
    return ThemeData.light().copyWith(
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
      useMaterial3: true,
    );
  }

  ThemeData dark() {
    final scheme = colors();
    return ThemeData.dark().copyWith(
      colorScheme: scheme,
      appBarTheme: appBarTheme(scheme),
      cardTheme: cardTheme(),
      listTileTheme: listTileTheme(scheme),
      bottomAppBarTheme: bottomAppBarTheme(scheme),
      bottomNavigationBarTheme: bottomNavigationBarTheme(scheme),
      navigationRailTheme: navigationRailTheme(scheme),
      tabBarTheme: tabBarTheme(scheme),
      drawerTheme: drawerTheme(scheme),
      useMaterial3: true,
    );
  }

  ThemeData get themeData => brightness == Brightness.dark ? dark() : light();

  CustomTheme copyWith({Brightness? brightness, Color? targetColor}) {
    return CustomTheme(brightness ?? this.brightness, targetColor ?? this.targetColor);
  }
}
