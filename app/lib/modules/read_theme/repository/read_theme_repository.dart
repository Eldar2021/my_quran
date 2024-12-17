import 'package:my_quran/modules/modules.dart';

abstract class ReadThemeRepository {
  ReadThemeState get getInitialThemeState;

  Future<void> saveThemeState(ReadThemeState themeState);
}
