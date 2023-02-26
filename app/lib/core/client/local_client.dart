import 'package:hive/hive.dart';

import 'package:my_quran/core/core.dart';

class LocalClient<T> {
  const LocalClient(this.box);

  final Box<T> box;

  Future<void> save({required String key, required T value}) async {
    try {
      await box.put(key, value);
    } catch (e) {
      throw LocalExc('hive service save error $e');
    }
  }

  T? read({required String key}) {
    try {
      return box.get(key);
    } catch (e) {
      throw LocalExc('hive service read error $e');
    }
  }

  Future<void> clear() async {
    try {
      await box.clear();
    } catch (e) {
      throw LocalExc('hive service clear error $e');
    }
  }
}
