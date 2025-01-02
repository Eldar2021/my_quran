import 'package:flutter/material.dart';
import 'package:mq_app_ui/mq_app_ui.dart';

@immutable
final class AppOrangeDarkTheme extends AppTheme {
  @override
  ColorScheme get colorScheme {
    return ColorScheme.fromSeed(
      seedColor: AppColors.tomato,
      primary: AppColors.tomato,
      onPrimary: AppColors.white,
      error: AppColors.darkred,
      onError: AppColors.white,
      brightness: Brightness.dark,
    );
  }

  @override
  ThemeData get themeData {
    return ThemeData(
      primaryColor: AppColors.tomato,
      splashColor: AppColors.transparent,
      textTheme: uiTextTheme,
      iconTheme: iconTheme,
      appBarTheme: appBarTheme,
      dividerTheme: dividerTheme,
      inputDecorationTheme: inputDecorationTheme,
      buttonTheme: buttonTheme,
      snackBarTheme: snackBarTheme,
      elevatedButtonTheme: elevatedButtonTheme,
      textButtonTheme: textButtonTheme,
      colorScheme: colorScheme,
      bottomSheetTheme: bottomSheetTheme,
      listTileTheme: listTileTheme,
      switchTheme: switchTheme,
      progressIndicatorTheme: progressIndicatorTheme,
      tabBarTheme: tabBarTheme,
      bottomNavigationBarTheme: bottomAppBarTheme,
      chipTheme: chipTheme,
    );
  }
}
