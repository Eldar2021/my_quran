import 'package:my_quran/modules/modules.dart';

class SaveThemeChangesUseCase {
  const SaveThemeChangesUseCase(this.repository);
  final ReadThemeRepository repository;

  Future<void> execute(ReadThemeState themeState) {
    return repository.saveThemeState(themeState);
  }
}
