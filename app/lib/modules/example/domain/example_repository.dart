import 'package:my_quran/modules/example/data/data.dart';

abstract class ExampleRepository {
  Future<List<ExampleUser>> getUsers();
  Future<List<ExamplePost>> getPosts(int id);
}
