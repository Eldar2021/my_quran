import 'package:mq_quran_repository/mq_quran_repository.dart';

class MqQuranRemoteDataSourceMock implements MqQuranRemoteDataSource {
  const MqQuranRemoteDataSourceMock();

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
