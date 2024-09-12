import 'package:mq_quran_api/src/datas/juz_data.dart';
import 'package:mq_quran_api/src/datas/surah_data.dart';
import 'package:mq_quran_api/src/models/juz_model.dart';
import 'package:mq_quran_api/src/models/surah_model.dart';

/// {@template mq_quran_api}
/// Quran Api package
/// {@endtemplate}
class MqQuranApi {
  /// {@macro mq_quran_api}
  const MqQuranApi();

  List<JuzModel> getJuzs() {
    final juzs = juzData.map(JuzModel.fromJson).toList();
    return juzs;
  }

  List<SurahModel> getSurahs() {
    final surahs = surahData.map(SurahModel.fromJson).toList().toList();
    return surahs;
  }
}
