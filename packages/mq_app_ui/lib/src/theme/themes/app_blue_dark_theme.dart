import 'package:flutter/material.dart';
import 'package:mq_app_ui/mq_app_ui.dart';

@immutable
final class AppBlueDarkTheme extends AppTheme {
  @override
  Color get backgroundColor => AppColors.black3;

  @override
  ColorScheme get colorScheme {
    return ColorScheme.fromSeed(
      seedColor: AppColors.darkslateblue,
      brightness: Brightness.dark,
    );
  }

  @override
  ThemeData get themeData {
    return ThemeData(
      primaryColor: AppColors.darkslateblue,
      splashColor: AppColors.transparent,
      textTheme: uiTextTheme,
      canvasColor: backgroundColor,
      scaffoldBackgroundColor: backgroundColor,
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
