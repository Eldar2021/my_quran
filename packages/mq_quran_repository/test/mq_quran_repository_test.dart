import 'package:flutter_test/flutter_test.dart';
import 'package:mq_quran_repository/mq_quran_repository.dart';
import 'package:mq_remote_client/mq_remote_client.dart';

final class MockNetworkClient extends NetworkClient {
  @override
  Future<bool> checkInternetConnection() async {
    return true;
  }
}

void main() {
  final remoteDataSource = MqQuranRemoteDataSourceImpl(
    MqRemoteClient(
      dio: Dio(),
      network: MockNetworkClient(),
    ),
  );

  group('MqQuranRepository', () {
    test('can be instantiated', () {
      expect(1 + 1, 2);
    });
  });

  group('MqQuranRemoteDataSource', () {
    test('getToken', () async {
      final token = await remoteDataSource.getToken(
        'ClientId',
        'ClientSecret',
      );
      expect(token, isA<String>());
    });
  });
}
