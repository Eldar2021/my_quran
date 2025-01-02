import 'package:flutter/material.dart';

abstract class AppTheme {
  ThemeData get themeData;

  ColorScheme get colorScheme;

  Color get backgroundColor;

  AppBarTheme get appBarTheme {
    return const AppBarTheme();
  }

  SnackBarThemeData get snackBarTheme {
    return const SnackBarThemeData();
  }

  IconThemeData get iconTheme {
    return const IconThemeData();
  }

  DividerThemeData get dividerTheme {
    return const DividerThemeData();
  }

  TextTheme get contentTextTheme {
    return const TextTheme();
  }

  TextTheme get uiTextTheme {
    return const TextTheme();
  }

  InputDecorationTheme get inputDecorationTheme {
    return const InputDecorationTheme();
  }

  ButtonThemeData get buttonTheme {
    return const ButtonThemeData();
  }

  ElevatedButtonThemeData get elevatedButtonTheme {
    return const ElevatedButtonThemeData();
  }

  TextButtonThemeData get textButtonTheme {
    return const TextButtonThemeData();
  }

  BottomSheetThemeData get bottomSheetTheme {
    return const BottomSheetThemeData();
  }

  ListTileThemeData get listTileTheme {
    return const ListTileThemeData();
  }

  SwitchThemeData get switchTheme {
    return const SwitchThemeData();
  }

  ProgressIndicatorThemeData get progressIndicatorTheme {
    return const ProgressIndicatorThemeData();
  }

  TabBarTheme get tabBarTheme {
    return const TabBarTheme();
  }

  InputBorder get textFieldBorder {
    return const OutlineInputBorder();
  }

  BottomNavigationBarThemeData get bottomAppBarTheme {
    return const BottomNavigationBarThemeData();
  }

  ChipThemeData get chipTheme {
    return const ChipThemeData();
  }
}
