import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mq_remote_client/mq_remote_client.dart';

import 'mock_network_client.dart';
import 'test_model.dart';

void main() {
  late MqRemoteClient client;

  const getListUrl = 'https://encointer.github.io/feed/community_messages/en/cm.json';
  const getUrl = 'https://eldar2021.github.io/encointer/test_data.json';
  const emptyList = 'https://eldar2021.github.io/encointer/test/empty_list.json';

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

      final mapResponse = await client.get<Map<String, dynamic>>(getUrl);
      mapResponse.fold((l) => null, (r) => mapValue = r);

      expect(mapValue, isNotNull);
      expect(mapValue, isMap);
      expect(mapValue, isA<Map<String, dynamic>>());

      final listResponse = await client.get<List<dynamic>>(getListUrl);
      listResponse.fold((l) => null, (r) => listValue = r);
      expect(listValue, isNotNull);
      expect(listValue, isList);
      expect(listValue?.isNotEmpty, true);
      expect(listValue, isA<List<dynamic>>());
    });

    test('Get Type', () async {
      TestModel? testModel;
      final response = await client.getType<TestModel>(
        getUrl,
        fromJson: TestModel.fromJson,
      );
      response.fold((l) => null, (r) => testModel = r);
      expect(testModel, isNotNull);
      expect(testModel, isA<TestModel>());
    });

    test('Get List Of Type', () async {
      List<TestModel>? testModelList;
      final response = await client.getListOfType<TestModel>(
        getListUrl,
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
}
