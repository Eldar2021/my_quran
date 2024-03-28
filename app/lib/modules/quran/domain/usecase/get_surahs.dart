import 'package:meta/meta.dart';
import 'package:my_quran/modules/modules.dart';

@immutable
final class GetSurahsUseCase {
  const GetSurahsUseCase(this.repository);

  final QuranRepository repository;

  List<SurahEntity> call() {
    return repository.getSurahs();
  }
}
