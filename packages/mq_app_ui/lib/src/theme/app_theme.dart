import 'package:flutter/material.dart';
import 'package:mq_app_ui/mq_app_ui.dart';

abstract class AppTheme {
  ThemeData get themeData;

  ColorScheme get colorScheme;

  TextTheme get textTheme;

  TextTheme get primaryTextTheme;

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

  InputDecorationTheme get inputDecorationTheme {
    return const InputDecorationTheme();
  }

  ButtonThemeData get buttonTheme {
    return const ButtonThemeData();
  }

  ElevatedButtonThemeData get elevatedButtonTheme {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        fixedSize: const Size.fromHeight(52),
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(99),
        ),
        textStyle: primaryTextTheme.titleMedium?.copyWith(fontSize: 18),
      ),
    );
  }

  OutlinedButtonThemeData get outlinedButtonTheme {
    return OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: colorScheme.primary),
        fixedSize: const Size.fromHeight(50),
        iconColor: colorScheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(99),
        ),
        textStyle: primaryTextTheme.titleMedium?.copyWith(fontSize: 18),
      ),
    );
  }

  TextButtonThemeData get textButtonTheme {
    return const TextButtonThemeData();
  }

  BottomSheetThemeData get bottomSheetTheme {
    return const BottomSheetThemeData();
  }

  ListTileThemeData get listTileTheme {
    return ListTileThemeData(
      titleTextStyle: primaryTextTheme.titleMedium?.copyWith(
        fontSize: 18,
      ),
    );
  }

  SwitchThemeData get switchTheme {
    return SwitchThemeData(
      trackOutlineColor: WidgetStateProperty.resolveWith(
        (states) => AppColors.transparent,
      ),
    );
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
