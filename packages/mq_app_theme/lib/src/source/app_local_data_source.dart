import 'package:mq_app_theme/mq_app_theme.dart';

abstract class AppLocalDataSource {
  String appVersion();

  CustomTheme initialTheme();

  Future<void> saveThemePrimaryColor(int index);

  Future<void> saveThemeMode({required bool isDark});
}
