import 'package:my_quran/theme/theme.dart';

abstract class ThemeRepository {
  CustomTheme get getInitialThemeState;
  Future<void> saveThemePrimaryColor(int index);
  Future<void> saveThemeMode({required bool isDark});
}
