import 'package:meta/meta.dart';
import 'package:my_quran/modules/modules.dart';

@immutable
final class GetAudioSurahsUseCase {
  const GetAudioSurahsUseCase(this.repository);

  final QuranAudioRepository repository;

  List<SurahEntity> call() {
    return repository.getSurahs();
  }
}
