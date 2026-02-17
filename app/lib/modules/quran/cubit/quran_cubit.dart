import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mq_quran_client/mq_quran_client.dart';

class QuranCubit extends Cubit<int> {
  QuranCubit(this.repository) : super(0);

  final QuranExtraRepository repository;

  void change(int? val) => emit(val ?? 0);

  List<QuranJuzModel> getJuz() {
    return repository.getJuzsData();
  }

  List<QuranSurahModel> getSurah() {
    return repository.getSurahsData();
  }
}
