import 'package:my_quran/modules/modules.dart';

abstract class ReadThemeRepository {
  Future<ReadThemeState> getInitialThemeState();
  Future<void> saveThemeState(ReadThemeState themeState);
}
