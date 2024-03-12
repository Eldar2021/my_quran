import 'package:meta/meta.dart';
import 'package:my_quran/modules/modules.dart';

@immutable
final class GetReadPageUseCase {
  const GetReadPageUseCase(this.repository);

  final ReadRepository repository;

  Future<QuranPageEntity?> getPage(int page, String quranFmt) {
    return repository.getPage(page, quranFmt);
  }
}
