import 'package:meta/meta.dart';
import 'package:my_quran/modules/modules.dart';

@immutable
final class JuzLocalDataSource {
  List<JuzResponse> getJuzsFromLocal() {
    final juzs = juzData.map(JuzResponse.fromJson).toList();
    return juzs;
  }
}
