import 'package:meta/meta.dart';
import 'package:mq_quran_client/mq_quran_client.dart';

@immutable
final class QuranExtraLocalDataSoruceImpl implements QuranExtraLocalDataSoruce {
  const QuranExtraLocalDataSoruceImpl();

  @override
  List<QuranJuzModel> getJuzsData() {
    return mqQuranJuzsData.map(QuranJuzModel.fromJson).toList();
  }

  @override
  List<QuranSurahModel> getSurahsData() {
    return mqQuranSurahsData.map(QuranSurahModel.fromJson).toList();
  }
}
