import 'package:flutter/material.dart';

mixin CompomnentTheme {
  ShapeBorder get shapeMedium => const RoundedRectangleBorder();

  ColorScheme get scheme;

  CardTheme get cardTheme {
    return const CardTheme();
  }

  ButtonThemeData get buttonTheme {
    return const ButtonThemeData();
  }

  ElevatedButtonThemeData get elevatedButtonThemeData {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(),
    );
  }

  InputDecorationTheme get inputDecorationTheme {
    return const InputDecorationTheme(
      border: OutlineInputBorder(),
    );
  }

  ListTileThemeData get listTileTheme {
    return const ListTileThemeData();
  }

  AppBarTheme get appBarTheme {
    return AppBarTheme(backgroundColor: scheme.surfaceVariant);
  }

  TabBarTheme get tabBarTheme {
    return const TabBarTheme();
  }

  BottomAppBarTheme get bottomAppBarTheme {
    return const BottomAppBarTheme();
  }

  BottomNavigationBarThemeData get bottomNavigationBarTheme {
    return const BottomNavigationBarThemeData();
  }

  NavigationRailThemeData get navigationRailTheme {
    return const NavigationRailThemeData();
  }

  DrawerThemeData get drawerTheme {
    return const DrawerThemeData();
  }

  ScrollbarThemeData get scrollbarThemeData {
    return const ScrollbarThemeData();
  }
}
