import 'package:my_quran/modules/modules.dart';

abstract class HomeRepository {
  Future<HomeModel> getData(String token);
}
