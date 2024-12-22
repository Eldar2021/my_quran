import 'package:my_quran/modules/modules.dart';

abstract class LocalThemeDataSource {
  ReadThemeData getInitialThemeState();

  Future<void> saveThemeState(ReadThemeData themeState);
}
