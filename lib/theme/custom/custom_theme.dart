import 'package:flutter/material.dart';
import 'package:hatim/theme/custom/color/custom_color.dart';
import 'package:hatim/theme/custom/component/componet_theme.dart';
import 'package:material_color_utilities/blend/blend.dart';

class CustomTheme with CompomnentTheme {
  const CustomTheme({
    required this.color,
    required this.mode,
  });

  final Color color;
  final bool mode;

  Color custom(CustomColor custom) {
    if (custom.blend) {
      return blend(custom.color);
    } else {
      return custom.color;
    }
  }

  Color blend(Color targetColor) {
    return Color(
      Blend.harmonize(targetColor.value, color.value),
    );
  }

  Color source(Color? target) {
    var source = color;
    if (target != null) {
      source = blend(target);
    }
    return source;
  }

  ColorScheme colors(Brightness brightness, Color? targetColor) {
    // final dynamicPrimary = brightness == Brightness.light
    //     ? lightDynamic?.primary
    //     : darkDynamic?.primary;
    return ColorScheme.fromSeed(
      seedColor: source(targetColor),
      brightness: brightness,
    );
  }

  ThemeData light([Color? targetColor]) {
    final scheme = colors(Brightness.light, targetColor);
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
      // scaffoldBackgroundColor: scheme.background,
      useMaterial3: true,
    );
  }

  ThemeData dark([Color? targetColor]) {
    final scheme = colors(Brightness.dark, targetColor);
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

  ThemeData get theme => mode ? light() : dark();

  CustomTheme copy({Color? newColor, bool? newMode}) {
    return CustomTheme(color: newColor ?? color, mode: newMode ?? mode);
  }
}
