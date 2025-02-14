import 'package:flutter/material.dart';
import 'package:mq_app_ui/mq_app_ui.dart';

@immutable
final class AppBlueTheme extends AppTheme {
  const AppBlueTheme();

  @override
  ColorScheme get colorScheme {
    return ColorScheme.fromSeed(
      seedColor: AppColors.darkslateblue,
      primary: AppColors.darkslateblue,
      onPrimary: AppColors.white,
      secondary: AppColors.dodgerblue,
      onSecondary: AppColors.white,
      tertiary: AppColors.cornflowerblue,
      onTertiary: AppColors.white,
      surface: AppColors.white,
      onSurface: AppColors.black,
      error: AppColors.darkred,
      onError: AppColors.white,
    );
  }

  @override
  ThemeData get themeData {
    return ThemeData(
      primaryColor: AppColors.darkslateblue,
      splashColor: AppColors.transparent,
      textTheme: textTheme,
      primaryTextTheme: primaryTextTheme,
      iconTheme: iconTheme,
      appBarTheme: appBarTheme,
      dividerTheme: dividerTheme,
      inputDecorationTheme: inputDecorationTheme,
      buttonTheme: buttonTheme,
      snackBarTheme: snackBarTheme,
      elevatedButtonTheme: elevatedButtonTheme,
      outlinedButtonTheme: outlinedButtonTheme,
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

  @override
  TextTheme get primaryTextTheme {
    return const TextTheme(
      displayLarge: AppTextStyles.displayLarge,
      displayMedium: AppTextStyles.displayMedium,
      displaySmall: AppTextStyles.displaySmall,
      headlineLarge: AppTextStyles.headlineLarge,
      headlineMedium: AppTextStyles.headlineMedium,
      headlineSmall: AppTextStyles.headlineSmall,
      titleLarge: AppTextStyles.titleLarge,
      titleMedium: AppTextStyles.titleMedium,
      titleSmall: AppTextStyles.titleSmall,
      bodyLarge: AppTextStyles.bodyLarge,
      bodyMedium: AppTextStyles.bodyMedium,
      bodySmall: AppTextStyles.bodySmall,
      labelLarge: AppTextStyles.labelLarge,
      labelMedium: AppTextStyles.labelMedium,
      labelSmall: AppTextStyles.labelSmall,
    ).apply(displayColor: AppColors.black, bodyColor: AppColors.black);
  }

  @override
  TextTheme get textTheme {
    return const TextTheme(
      displayLarge: AppTextStyles.displayLarge,
      displayMedium: AppTextStyles.displayMedium,
      displaySmall: AppTextStyles.displaySmall,
      headlineLarge: AppTextStyles.headlineLarge,
      headlineMedium: AppTextStyles.headlineMedium,
      headlineSmall: AppTextStyles.headlineSmall,
      titleLarge: AppTextStyles.titleLarge,
      titleMedium: AppTextStyles.titleMedium,
      titleSmall: AppTextStyles.titleSmall,
      bodyLarge: AppTextStyles.bodyLarge,
      bodyMedium: AppTextStyles.bodyMedium,
      bodySmall: AppTextStyles.bodySmall,
      labelLarge: AppTextStyles.labelLarge,
      labelMedium: AppTextStyles.labelMedium,
      labelSmall: AppTextStyles.labelSmall,
    ).apply(displayColor: AppColors.darkslategray2, bodyColor: AppColors.darkslategray2);
  }
}
