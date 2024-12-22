import 'package:mq_app_theme/mq_app_theme.dart';

abstract class AppRepository {
  String appVersion();

  CustomTheme getInitialThemeState();

  Future<void> saveThemePrimaryColor(int index);

  Future<void> saveThemeMode({required bool isDark});
}
