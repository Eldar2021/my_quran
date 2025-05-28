import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mq_remote_client/mq_remote_client.dart';

import 'helpers/mock_network_client.dart';
import 'helpers/test_model.dart';

void main() {
  late MqRemoteClient client;

  const emptyList = 'https://eldar2021.github.io/encointer/test/empty_list.json';
  const postList = 'https://jsonplaceholder.typicode.com/posts';
  const postDatas = 'https://jsonplaceholder.typicode.com/posts/1';
  const postListGet = 'https://eldar2021.github.io/my-quran/tests/posts.json';
  const postDatasGet = 'https://eldar2021.github.io/my-quran/tests/post.json';

  final requestBody = {'title': 'foo', 'body': 'bar', 'userId': 1};

  setUp(() => client = MqRemoteClient(dio: Dio(), network: MockNetworkClient()));

  group('MqRemoteClient `get`, `getType`, `getListOfType`', () {
    test('Get', () async {
      final mapValue = await client.get<Map<String, dynamic>>(postDatasGet);

      expect(mapValue, isNotNull);
      expect(mapValue, isMap);
      expect(mapValue, isA<Map<String, dynamic>>());

      final listValue = await client.get<List<dynamic>>(postListGet);
      expect(listValue, isNotNull);
      expect(listValue, isList);
      expect(listValue.isNotEmpty, true);
      expect(listValue, isA<List<dynamic>>());
    });

    test('Get Type', () async {
      final testModel = await client.getType<TestModel>(postDatasGet, fromJson: TestModel.fromJson);
      expect(testModel, isNotNull);
      expect(testModel, isA<TestModel>());
    });

    test('Get List Of Type', () async {
      final testModelList = await client.getListOfType<TestModel>(postListGet, fromJson: TestModel.fromJson);
      expect(testModelList, isNotNull);
      expect(testModelList, isList);
      expect(testModelList, isA<List<TestModel>>());
      expect(testModelList[0], isA<TestModel>());
    });

    test('Get empty List', () async {
      final testModelList = await client.getListOfType<TestModel>(emptyList, fromJson: TestModel.fromJson);
      expect(testModelList, isNotNull);
      expect(testModelList, isList);
      expect(testModelList, isA<List<TestModel>>());
      expect(testModelList.isEmpty, true);
    });
  });

  group('MqRemoteClient `post`, `postType`, `postListOfType`', () {
    test('Post', () async {
      final mapValue = await client.post<Map<String, dynamic>>(postList, body: requestBody);

      expect(mapValue, isNotNull);
      expect(mapValue, isA<Map<String, dynamic>>());
    });

    test('Post Type', () async {
      final testModel = await client.postType<TestModel>(postList, body: requestBody, fromJson: TestModel.fromJson);

      expect(testModel, isA<TestModel>());
    });
  });

  group('MqRemoteClient `put`, `putType`, `putListOfType`', () {
    test('Put', () async {
      final mapValue = await client.put<Map<String, dynamic>>(postDatas, body: requestBody);
      expect(mapValue, isNotNull);

      expect(mapValue, isA<Map<String, dynamic>>());
    });

    test('Put Type', () async {
      final testModel = await client.putType<TestModel>(postDatas, body: requestBody, fromJson: TestModel.fromJson);

      expect(testModel, isA<TestModel>());
    });
  });

  group('MqRemoteClient `patch`, `patchType`, `patchListOfType`', () {
    test('Patch', () async {
      final mapValue = await client.patch<Map<String, dynamic>>(postDatas, fromJson: (json) => json, body: requestBody);

      expect(mapValue, isNotNull);
      expect(mapValue, isA<Map<String, dynamic>>());
    });

    test('Patch Type', () async {
      final testModel = await client.patchType<TestModel>(postDatas, body: requestBody, fromJson: TestModel.fromJson);

      expect(testModel, isA<TestModel>());
    });
  });
}
