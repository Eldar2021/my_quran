import 'package:mq_quran_repository/mq_quran_repository.dart';

class MqQuranRemoteDataSourceMock implements MqQuranRemoteDataSource {
  @override
  Future<QuranPageResponse?> fetchPage(int page, String quranFmt) async {
    return const QuranPageResponse(
      verses: [],
      meta: MetaResponse(filters: FiltersResponse(pageNumber: '1')),
    );
  }
}
