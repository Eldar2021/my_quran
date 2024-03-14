import 'package:my_quran/theme/theme.dart';

abstract class ThemeRepository {
  CustomTheme get getInitialThemeState;
  Future<void> setColor(int index);
  Future<void> setMode({required bool isDark});
}
