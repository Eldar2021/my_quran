import 'package:mq_app_theme/mq_app_theme.dart';

abstract class LocalThemeDataSource {
  ReadThemeData getInitialThemeState();

  Future<void> saveThemeState(ReadThemeData themeState);
}
