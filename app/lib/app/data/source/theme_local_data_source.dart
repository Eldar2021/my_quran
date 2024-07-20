import 'package:my_quran/theme/theme.dart';

abstract class ThemeLocalDataSource {
  CustomTheme get initialTheme;
  Future<void> saveThemePrimaryColor(int index);
  Future<void> saveThemeMode({required bool isDark});
}
