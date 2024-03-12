import 'package:meta/meta.dart';
import 'package:my_quran/modules/modules.dart';

@immutable
final class SaveThemeChangesUseCase {
  const SaveThemeChangesUseCase(this.repository);

  final ReadThemeRepository repository;

  Future<void> execute(ReadThemeState themeState) {
    return repository.saveThemeState(themeState);
  }
}
