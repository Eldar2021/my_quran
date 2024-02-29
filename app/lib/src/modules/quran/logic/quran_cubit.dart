import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:my_quran/src/models/models.dart';

class QuranCubit extends Cubit<int> {
  QuranCubit() : super(0);

  void change(int? val) => emit(val ?? 0);

  final List<Juz> juzs = juzData.map(Juz.fromJson).toList();

  final List<Surah> surahs = surahData.map(Surah.fromJson).toList();
}
