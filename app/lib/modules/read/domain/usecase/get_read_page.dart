import 'package:my_quran/modules/modules.dart';

class GetReadPageUseCase {
  const GetReadPageUseCase(this.repository);

  final ReadRepository repository;

  Future<QuranPage?> getPage(int page, String quranFmt) {
    return repository.getPage(page, quranFmt);
  }
}
