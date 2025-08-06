import 'dart:developer';

import 'package:mq_remote_client/mq_remote_client.dart';
import 'package:my_quran/modules/example/data/models/example_post.dart';
import 'package:my_quran/modules/example/data/models/example_user.dart';

class ExampleService {
  const ExampleService(this._client);

  final MqRemoteClient _client;

  Future<List<ExampleUser>> getUsers() async {
    try {
      final data = await _client.getListOfType(
        'https://jsonplaceholder.typicode.com/users',
        fromJson: ExampleUser.fromJson,
      );
      return data;
    } catch (e) {
      log('getUsers error: $e');
      rethrow;
    }
  }

  Future<List<ExamplePost>> getPosts(int id) async {
    try {
      final data = await _client.getListOfType(
        'https://jsonplaceholder.typicode.com/posts?userId=$id',
        fromJson: ExamplePost.fromJson,
      );
      return data;
    } catch (e) {
      log('getPosts error: $e');
      rethrow;
    }
  }
}
