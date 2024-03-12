import 'package:meta/meta.dart';
import 'package:my_quran/modules/modules.dart';

@immutable
final class GetInitialThemeUseCase {
  const GetInitialThemeUseCase(this.repository);

  final ReadThemeRepository repository;

  ReadThemeState get execute {
    return repository.getInitialThemeState;
  }
}
