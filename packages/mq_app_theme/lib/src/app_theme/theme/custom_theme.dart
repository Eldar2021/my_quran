import 'package:flutter/material.dart';
import 'package:mq_app_theme/mq_app_theme.dart';

@immutable
final class CustomTheme with CompomnentTheme {
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
      appBarTheme: appBarTheme,
      cardTheme: cardTheme,
      listTileTheme: listTileTheme,
      bottomAppBarTheme: bottomAppBarTheme,
      bottomNavigationBarTheme: bottomNavigationBarTheme,
      navigationRailTheme: navigationRailTheme,
      tabBarTheme: tabBarTheme,
      drawerTheme: drawerTheme,
      buttonTheme: buttonTheme,
      inputDecorationTheme: inputDecorationTheme,
      elevatedButtonTheme: elevatedButtonThemeData,
      scrollbarTheme: scrollbarThemeData,
    );
  }

  ThemeData get light => _base.copyWith(brightness: Brightness.light);

  ThemeData get dark => _base.copyWith(brightness: Brightness.dark);

  ThemeData get themeData => brightness == Brightness.dark ? dark : light;

  CustomTheme copyWith({Brightness? brightness, Color? targetColor}) {
    return CustomTheme(brightness ?? this.brightness, targetColor ?? this.targetColor);
  }
}
