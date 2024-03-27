import 'package:meta/meta.dart';
import 'package:my_quran/app/app.dart';

@immutable
final class SetModeUseCase {
  const SetModeUseCase(this.themeRepository);

  final ThemeRepository themeRepository;

  Future<void> call({required bool isDark}) async {
    await themeRepository.saveThemeMode(isDark: isDark);
  }
}
