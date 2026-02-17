import 'package:meta/meta.dart';
import 'package:mq_quran_client/mq_quran_client.dart';

@immutable
final class QuranExtraLocalDataSoruceMock implements QuranExtraLocalDataSoruce {
  const QuranExtraLocalDataSoruceMock();

  @override
  List<QuranJuzModel> getJuzsData() {
    return mqQuranJuzsData.map(QuranJuzModel.fromJson).toList();
  }

  @override
  List<QuranSurahModel> getSurahsData() {
    return mqQuranSurahsData.map(QuranSurahModel.fromJson).toList();
  }
}
