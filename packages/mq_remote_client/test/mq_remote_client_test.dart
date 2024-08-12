import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mq_remote_client/mq_remote_client.dart';

import 'mock_network_client.dart';
import 'test_model.dart';

void main() {
  late MqRemoteClient client;

  const emptyList = 'https://eldar2021.github.io/encointer/test/empty_list.json';
  const postList = 'https://jsonplaceholder.typicode.com/posts';
  const postDatas = 'https://jsonplaceholder.typicode.com/posts/1';

  final requestBody = {
    'title': 'foo',
    'body': 'bar',
    'userId': 1,
  };

  setUp(
    () => client = MqRemoteClient(
      dio: Dio(),
      network: MockNetworkClient(),
    ),
  );

  group('MqRemoteClient `get`, `getType`, `getListOfType`', () {
    test('Get', () async {
      Map<String, dynamic>? mapValue;
      List<dynamic>? listValue;

      final mapResponse = await client.get<Map<String, dynamic>>(postDatas);
      mapResponse.fold((l) => null, (r) => mapValue = r);

      expect(mapValue, isNotNull);
      expect(mapValue, isMap);
      expect(mapValue, isA<Map<String, dynamic>>());

      final listResponse = await client.get<List<dynamic>>(postList);
      listResponse.fold((l) => null, (r) => listValue = r);
      expect(listValue, isNotNull);
      expect(listValue, isList);
      expect(listValue?.isNotEmpty, true);
      expect(listValue, isA<List<dynamic>>());
    });

    test('Get Type', () async {
      TestModel? testModel;
      final response = await client.getType<TestModel>(
        postDatas,
        fromJson: TestModel.fromJson,
      );
      response.fold((l) => null, (r) => testModel = r);
      expect(testModel, isNotNull);
      expect(testModel, isA<TestModel>());
    });

    test('Get List Of Type', () async {
      List<TestModel>? testModelList;
      final response = await client.getListOfType<TestModel>(
        postList,
        fromJson: TestModel.fromJson,
      );
      response.fold((l) => null, (r) => testModelList = r);
      expect(testModelList, isNotNull);
      expect(testModelList, isList);
      expect(testModelList, isA<List<TestModel>>());
      expect(testModelList?[0], isA<TestModel>());
    });

    test('Get empty List', () async {
      List<TestModel>? testModelList;
      final response = await client.getListOfType<TestModel>(
        emptyList,
        fromJson: TestModel.fromJson,
      );
      response.fold((l) => null, (r) => testModelList = r);
      expect(testModelList, isNotNull);
      expect(testModelList, isList);
      expect(testModelList, isA<List<TestModel>>());
      expect(testModelList?.isEmpty, true);
    });
  });

  group('MqRemoteClient `post`, `postType`, `postListOfType`', () {
    test('Post', () async {
      TestModel? mapValue;

      final mapResponse = await client.post<TestModel>(postDatas, body: requestBody);
      mapResponse.fold((l) => null, (r) => mapValue = r);

      expect(mapValue, isNotNull);
      expect(mapValue, isA<Map<String, dynamic>>());
    });

    test('Post Type', () async {
      TestModel? testModel;
      final response = await client.postType<TestModel>(
        postDatas,
        body: requestBody,
        fromJson: TestModel.fromJson,
      );
      response.fold((l) => null, (r) => testModel = r);

      expect(testModel, isA<TestModel>());
    });

    test('Post List Of Type', () async {
      List<TestModel>? testModelList;
      final response = await client.postListOfType<TestModel>(
        postList,
        body: requestBody,
        fromJson: TestModel.fromJson,
      );
      response.fold((l) => null, (r) => testModelList = r);

      expect(testModelList, isList);
      expect(testModelList, isA<List<TestModel>>());
      expect(testModelList?[0], isA<TestModel>());
    });
  });

  group('MqRemoteClient `put`, `putType`, `putListOfType`', () {
    test('Put', () async {
      Map<String, dynamic>? mapValue;

      final mapResponse = await client.put<Map<String, dynamic>>(postDatas, body: requestBody);
      mapResponse.fold((l) => null, (r) => mapValue = r);

      expect(mapValue, isA<Map<String, dynamic>>());
    });

    test('Put Type', () async {
      TestModel? testModel;
      final response = await client.putType<TestModel>(
        postDatas,
        body: requestBody,
        fromJson: TestModel.fromJson,
      );
      response.fold((l) => null, (r) => testModel = r);
      expect(testModel, isA<TestModel>());
    });

    test('Put List Of Type', () async {
      List<TestModel>? testModelList;
      final response = await client.putListOfType<TestModel>(
        postList,
        body: requestBody,
        fromJson: TestModel.fromJson,
      );
      response.fold((l) => null, (r) => testModelList = r);
      expect(testModelList, isList);
      expect(testModelList, isA<List<TestModel>>());
      expect(testModelList?[0], isA<TestModel>());
    });
  });

  group('MqRemoteClient `patch`, `patchType`, `patchListOfType`', () {
    test('Patch', () async {
      TestModel? testModel;

      final mapResponse = await client.patch<TestModel>(
        postDatas,
        body: requestBody,
        fromJson: TestModel.fromJson,
      );
      mapResponse.fold((l) => null, (r) => testModel = r);

      expect(testModel, isA<Map<String, dynamic>>());
    });

    test('Patch Type', () async {
      TestModel? testModel;
      final response = await client.patchType<TestModel>(
        postDatas,
        body: requestBody,
        fromJson: TestModel.fromJson,
      );
      response.fold((l) => null, (r) => testModel = r);
      expect(testModel, isA<TestModel>());
    });

    test('Patch List Of Type', () async {
      List<TestModel>? testModelList;
      final response = await client.patchListOfType<TestModel>(
        postList,
        body: requestBody,
        fromJson: TestModel.fromJson,
      );
      response.fold((l) => null, (r) => testModelList = r);

      expect(testModelList, isList);
      expect(testModelList, isA<List<TestModel>>());
      expect(testModelList?[0], isA<TestModel>());
    });
  });
}
