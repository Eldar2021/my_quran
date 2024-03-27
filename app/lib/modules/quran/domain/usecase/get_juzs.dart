import 'package:meta/meta.dart';
import 'package:my_quran/modules/modules.dart';

@immutable
final class GetJuzUseCase {
  const GetJuzUseCase(this.repository);

  final QuranRepository repository;

  List<JuzEntity> call() {
    return repository.getJuzs();
  }
}
