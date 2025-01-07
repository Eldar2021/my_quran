import 'package:mq_app_ui/mq_app_ui.dart';

abstract class LocalThemeDataSource {
  ReadThemeData getInitialThemeState();

  Future<void> saveThemeState(ReadThemeData themeState);
}
