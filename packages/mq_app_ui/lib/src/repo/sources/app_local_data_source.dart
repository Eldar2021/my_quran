import 'package:mq_app_ui/mq_app_ui.dart';

abstract class AppLocalDataSource {
  AppTheme initialTheme();

  Future<void> saveThemePrimaryColor({required bool isOrange});

  Future<void> saveThemeMode({required bool isDark});
}
