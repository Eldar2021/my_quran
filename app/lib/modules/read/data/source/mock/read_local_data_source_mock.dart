import 'package:meta/meta.dart';
import 'package:my_quran/modules/modules.dart';

@immutable
final class ReadLocalDataSourceMock implements ReadLocalDataSource {
  const ReadLocalDataSourceMock();

  @override
  QuranPageResponse? getPage(int page, String quranFmt) => null;

  @override
  Future<void> cachePage(int page, String quranFmt, QuranPageResponse pageData) => Future.value();
}
