import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mq_either/mq_either.dart';
import 'package:mq_remote_client/mq_remote_client.dart';

class MockClient extends Mock implements MqRemoteClient {}

void main() {
  late MockClient client;
  const mockUrl = 'https://jsonplaceholder.typicode.com/posts';
  const mockValue = 'mock-value';

  final requestBody = {'key': 'value'};
  final mockResponse = {'responseKey': 'responseValue'};

  setUp(() {
    client = MockClient();
  });

  group('GET requests', () {
    test('Success', () async {
      when(() => client.get<String>(mockUrl)).thenAnswer((_) async => const Right(mockValue));

      final result = await client.get<String>(mockUrl);

      final value = result.fold(
        (error) => fail('Expected a successful result but got an error: $error'),
        (data) => data,
      );

      expect(value, mockValue);
    });

    test('with type', () async {
      when(
        () => client.getType<String>(mockUrl, fromJson: any(named: 'fromJson')),
      ).thenAnswer((_) async => const Right<String, MqRemoteException>(mockValue));

      final result = await client.getType<String>(mockUrl, fromJson: (json) => json as String);

      final value = result.fold(
        (error) => fail('Expected a successful result but got an error: $error'),
        (data) => data,
      );

      expect(value, mockValue);
    });

    test('with list of type', () async {
      when(
        () => client.getListOfType<Map<String, dynamic>>(mockUrl, fromJson: any(named: 'fromJson')),
      ).thenAnswer(
        (_) async => const Right([
          {'key': mockValue},
        ]),
      );

      final result = await client.getListOfType<Map<String, dynamic>>(mockUrl, fromJson: (json) => json);

      expect(
        result,
        const Right<List<Map<String, dynamic>>, dynamic>([
          {'key': mockValue},
        ]),
      );
    });
  });

  group('POST requests', () {
    test('successful', () async {
      when(
        () => client.post<Map<String, dynamic>>(
          mockUrl,
          body: requestBody,
        ),
      ).thenAnswer(
        (_) async => const Right({'key': 'value'}),
      );

      final result = await client.post<Map<String, dynamic>>(
        mockUrl,
        body: requestBody,
      );

      expect(result, const Right<Map<String, dynamic>, dynamic>({'key': 'value'}));
    });

    test('with type', () async {
      when(
        () => client.postType<Map<String, dynamic>>(
          mockUrl,
          body: requestBody,
          fromJson: any(named: 'fromJson'),
        ),
      ).thenAnswer(
        (_) async => const Right({'key': 'value'}),
      );

      final result = await client.postType<Map<String, dynamic>>(
        mockUrl,
        body: requestBody,
        fromJson: (json) => json,
      );

      expect(result, const Right<Map<String, dynamic>, dynamic>({'key': 'value'}));
    });

    test('List of type', () async {
      when(
        () => client.postListOfType<Map<String, dynamic>>(
          mockUrl,
          fromJson: any(named: 'fromJson'),
        ),
      ).thenAnswer(
        (_) async => const Right([
          {'key': 'value'},
        ]),
      );

      final result = await client.postListOfType<Map<String, dynamic>>(
        mockUrl,
        fromJson: (json) => json,
      );

      expect(
        result,
        const Right<List<Map<String, dynamic>>, dynamic>([
          {'key': 'value'},
        ]),
      );
    });
  });

  group('PUT requests', () {
    test('successful', () async {
      when(
        () => client.put<Map<String, dynamic>>(
          mockUrl,
          body: requestBody,
        ),
      ).thenAnswer(
        (_) async => const Right({'key': 'value'}),
      );

      final result = await client.put<Map<String, dynamic>>(
        mockUrl,
        body: requestBody,
      );

      expect(result, const Right<Map<String, dynamic>, dynamic>({'key': 'value'}));
    });

    test('with type', () async {
      when(
        () => client.putType<Map<String, dynamic>>(
          mockUrl,
          body: requestBody,
          fromJson: any(named: 'fromJson'),
        ),
      ).thenAnswer(
        (_) async => const Right({'key': 'value'}),
      );

      final result = await client.putType<Map<String, dynamic>>(
        mockUrl,
        body: requestBody,
        fromJson: (json) => json,
      );

      expect(result, const Right<Map<String, dynamic>, dynamic>({'key': 'value'}));
    });

    test('list of type', () async {
      when(
        () => client.putListOfType<Map<String, dynamic>>(
          mockUrl,
          fromJson: any(named: 'fromJson'),
        ),
      ).thenAnswer(
        (_) async => const Right([
          {'key': 'value'},
        ]),
      );

      final result = await client.putListOfType<Map<String, dynamic>>(mockUrl, fromJson: (json) => json);

      expect(
        result,
        const Right<List<Map<String, dynamic>>, dynamic>([
          {'key': 'value'},
        ]),
      );
    });
  });
  group('PATCH requests', () {
    test('successful', () async {
      when(
        () => client.patch<Map<String, dynamic>>(mockUrl, body: requestBody, fromJson: any(named: 'fromJson')),
      ).thenAnswer((_) async => Right<Map<String, dynamic>, MqRemoteException>(mockResponse));

      final result = await client.patch<Map<String, dynamic>>(mockUrl, body: requestBody, fromJson: (json) => json);

      expect(result, isA<Right<Map<String, dynamic>, MqRemoteException>>());
    });

    test('with type', () async {
      when(
        () => client.patchType<Map<String, dynamic>>(mockUrl, body: requestBody, fromJson: any(named: 'fromJson')),
      ).thenAnswer(
        (_) async => Right<Map<String, dynamic>, MqRemoteException>(mockResponse),
      );

      final result = await client.patchType<Map<String, dynamic>>(mockUrl, body: requestBody, fromJson: (json) => json);

      expect(result, isA<Right<Map<String, dynamic>, MqRemoteException>>());
    });

    test('list of type', () async {
      when(
        () => client.patchListOfType<Map<String, dynamic>>(mockUrl, fromJson: any(named: 'fromJson')),
      ).thenAnswer(
        (_) async => const Right<List<Map<String, dynamic>>, MqRemoteException>([
          {'key': 'value'},
        ]),
      );

      final result = await client.patchListOfType<Map<String, dynamic>>(mockUrl, fromJson: (json) => json);

      expect(result, isA<Right<List<Map<String, dynamic>>, MqRemoteException>>());
    });
  });
}
