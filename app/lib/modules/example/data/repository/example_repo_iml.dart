import 'dart:async';
import 'dart:developer';

import 'package:my_quran/modules/example/data/models/example_post.dart';
import 'package:my_quran/modules/example/data/models/example_user.dart';
import 'package:my_quran/modules/example/data/sources/example_service.dart';
import 'package:my_quran/modules/example/domain/example_repository.dart';

class ExampleRepoIml implements ExampleRepository {
  ExampleRepoIml(this._service);

  final ExampleService _service;

  final Map<int, List<ExamplePost>> _posts = {};

  @override
  Future<List<ExamplePost>> getPosts(int id) async {
    log('Test: getPosts callled');
    if (_posts[id] != null) {
      log('Test: getPosts local');
      return Future.value(_posts[id]);
    } else {
      log('Test: getPosts network');
      final data = await _service.getPosts(id);
      _posts[id] = data;
      return data;
    }
  }

  @override
  Future<List<ExampleUser>> getUsers() {
    return _service.getUsers();
  }
}
