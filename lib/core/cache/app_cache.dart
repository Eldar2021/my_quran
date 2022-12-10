import 'package:hive/hive.dart';

import 'package:hatim/core/core.dart';

class AppCache<T> {
  const AppCache(this.box);

  final Box<T> box;

  Future<void> save({required String key, required T value}) async {
    try {
      await box.put(key, value);
    } catch (e) {
      throw LocalExc('AppCache save error $e');
    }
  }

  T? read({required String key}) {
    try {
      return box.get(key);
    } catch (e) {
      throw LocalExc('AppCache read error $e');
    }
  }

  Future<void> clear() async {
    try {
      await box.clear();
    } catch (e) {
      throw LocalExc('AppCache clear error $e');
    }
  }
}
