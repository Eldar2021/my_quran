import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mq_remote_client/mq_remote_client.dart';

class MockConnectivity extends Mock implements Connectivity {}

void main() {
  group('NetworkClient', () {
    late MockConnectivity mockConnectivity;
    late NetworkClient networkClient;

    setUp(() {
      mockConnectivity = MockConnectivity();
      networkClient = NetworkClient(connectivity: mockConnectivity);
    });

    test('returns true when connected via Wi-Fi', () async {
      when(() => mockConnectivity.checkConnectivity()).thenAnswer((_) async => [ConnectivityResult.wifi]);

      final result = await networkClient.checkInternetConnection();

      expect(result, isTrue);
    });

    test('returns true when connected via mobile', () async {
      when(() => mockConnectivity.checkConnectivity()).thenAnswer((_) async => [ConnectivityResult.mobile]);

      final result = await networkClient.checkInternetConnection();

      expect(result, isTrue);
    });

    test('returns false when not connected', () async {
      when(() => mockConnectivity.checkConnectivity()).thenAnswer((_) async => [ConnectivityResult.none]);

      final result = await networkClient.checkInternetConnection();

      expect(result, isFalse);
    });

    test('returns false when connected via bluetooth', () async {
      when(() => mockConnectivity.checkConnectivity()).thenAnswer((_) async => [ConnectivityResult.bluetooth]);

      final result = await networkClient.checkInternetConnection();

      expect(result, isFalse);
    });
  });
}
