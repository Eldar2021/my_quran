import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mq_remote_client/mq_remote_client.dart';

class MockDio extends Mock implements Dio {}

void main() {
  group('MqRemoteClient', () {
    test('can be instantiated', () {
      expect(
        MqRemoteClient(dio: MockDio(), network: NetworkClient(Connectivity())),
        isNotNull,
      );
    });
  });
}
