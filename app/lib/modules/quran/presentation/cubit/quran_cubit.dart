import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_quran/modules/modules.dart';

class QuranCubit extends Cubit<int> {
  QuranCubit() : super(0) {
    juzs = juzData.map((data) => _convertJuzData(JuzResponse.fromJson(data))).toList();
    surahs = surahData.map((data) => _convertSurahData(SurahResponse.fromJson(data))).toList();
  }

  void change(int? val) => emit(val ?? 0);

  SurahEntity _convertSurahData(SurahResponse response) {
    return SurahEntity(
      id: response.id,
      name: response.name,
      aya: response.aya,
      pages: response.pages,
      arabic: response.arabic,
    );
  }

  JuzEntity _convertJuzData(JuzResponse response) {
    final convertedSurahs = response.surahs
        .map(
          (juzSurahResponse) => JuzSurahEntity(
            name: juzSurahResponse.name,
            arName: juzSurahResponse.arName,
            pages: juzSurahResponse.pages,
          ),
        )
        .toList();

    return JuzEntity(
      id: response.id,
      name: response.name,
      pages: response.pages,
      surahs: convertedSurahs,
    );
  }

  late final List<JuzEntity> juzs;
  late final List<SurahEntity> surahs;
}
