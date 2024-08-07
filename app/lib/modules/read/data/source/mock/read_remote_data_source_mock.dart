import 'package:my_quran/modules/modules.dart';

class ReadRemoteDataSourceMock implements ReadRemoteDataSource {
  @override
  Future<QuranPageResponse?> fetchPage(int page, String quranFmt) async {
    return const QuranPageResponse(
      verses: [],
      meta: MetaResponse(filters: FiltersResponse(pageNumber: '1')),
    );
  }
}
