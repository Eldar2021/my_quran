import 'package:meta/meta.dart';
import 'package:my_quran/app/app.dart';
import 'package:my_quran/theme/theme.dart';

@immutable
final class GetAppInitialThemeUseCase {
  const GetAppInitialThemeUseCase(this.themeRepository);

  final ThemeRepository themeRepository;

  CustomTheme get call {
    return themeRepository.getInitialThemeState;
  }
}
