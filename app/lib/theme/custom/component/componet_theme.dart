import 'package:flutter/material.dart';

mixin CompomnentTheme {
  ShapeBorder get shapeMedium => const RoundedRectangleBorder();

  CardTheme cardTheme() {
    return const CardTheme();
  }

  ButtonThemeData buttonTheme(ColorScheme colors) {
    return const ButtonThemeData();
  }

  ElevatedButtonThemeData elevatedButtonThemeData(ColorScheme colors) {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(),
    );
  }

  InputDecorationTheme inputDecorationTheme(ColorScheme colors) {
    return const InputDecorationTheme(
      border: OutlineInputBorder(),
    );
  }

  ListTileThemeData listTileTheme(ColorScheme colors) {
    return const ListTileThemeData();
  }

  AppBarTheme appBarTheme(ColorScheme colors) {
    return AppBarTheme(backgroundColor: colors.surfaceVariant);
  }

  TabBarTheme tabBarTheme(ColorScheme colors) {
    return const TabBarTheme();
  }

  BottomAppBarTheme bottomAppBarTheme(ColorScheme colors) {
    return const BottomAppBarTheme();
  }

  BottomNavigationBarThemeData bottomNavigationBarTheme(ColorScheme colors) {
    return const BottomNavigationBarThemeData();
  }

  NavigationRailThemeData navigationRailTheme(ColorScheme colors) {
    return const NavigationRailThemeData();
  }

  DrawerThemeData drawerTheme(ColorScheme colors) {
    return const DrawerThemeData();
  }

  ScrollbarThemeData scrollbarThemeData(ColorScheme colors) {
    return const ScrollbarThemeData();
  }
}
