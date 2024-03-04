import 'package:my_quran/modules/modules.dart';

class GetInitialThemeUseCase {
  const GetInitialThemeUseCase(this.repository);
  final ReadThemeRepository repository;

  Future<ReadThemeState> execute() {
    return repository.getInitialThemeState();
  }
}
