// import 'package:flutter/material.dart';
// import 'package:mq_app_theme/mq_app_theme.dart';

// @immutable
// final class AppRepositoryImpl implements AppRepository {
//   const AppRepositoryImpl(
//     this.dataSource,
//   );

//   final AppLocalDataSource dataSource;

//   @override
//   String appVersion() => dataSource.appVersion();

//   @override
//   CustomTheme getInitialThemeState() {
//     return dataSource.initialTheme();
//   }

//   @override
//   Future<void> saveThemeMode({required bool isDark}) {
//     return dataSource.saveThemeMode(isDark: isDark);
//   }

//   @override
//   Future<void> saveThemePrimaryColor(int index) {
//     return dataSource.saveThemePrimaryColor(index);
//   }
// }
