import 'package:my_quran/modules/modules.dart';

abstract class LocalThemeDataSource {
  ReadThemeState get initialTheme;
  Future<void> saveThemeState(ReadThemeState themeState);
}
