import 'package:mq_quran_client/mq_quran_client.dart';

class QuranExtraRemoteDataSourceMock implements QuranExtraRemoteDataSource {
  const QuranExtraRemoteDataSourceMock();

  @override
  Future<bool> setDonPages({
    required List<int> pageNumber,
    required String status,
    String? hatimId,
  }) async {
    await Future<void>.delayed(const Duration(seconds: 1));
    return true;
  }
}
