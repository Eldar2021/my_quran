import 'dart:convert';
import 'package:mq_storage/mq_storage.dart';
import 'package:my_quran/modules/modules.dart';

class HomeLocalDataSource {
  HomeLocalDataSource(this.storage);

  final PreferencesStorage storage;
  HomeModel getLocalData() {
    const key = 'home-model';
    final localValue = storage.readString(key: key);
    if (localValue != null) {
      final data = jsonDecode(localValue);
      return HomeModel.fromJson(data as Map<String, dynamic>);
    } else {
      return const HomeModel(allDoneHatims: 0, allDonePages: 0, donePages: 0);
    }
  }
  // Future<HomeModel> getLocalData() async {
  //   const key = 'home-model';
  //   final localValue = storage.readString(key: key);
  //   if (localValue != null) {
  //     final data = jsonDecode(localValue);
  //     return HomeModel.fromJson(data as Map<String, dynamic>);
  //   } else {
  //     return const HomeModel(allDoneHatims: 0, allDonePages: 0, donePages: 0);
  //   }
  // }

  Future<void> saveLocalData(HomeModel data) async {
    const key = 'home-model';
    await storage.writeString(key: key, value: jsonEncode(data.toJson()));
  }
}
