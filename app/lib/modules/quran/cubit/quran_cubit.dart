import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mq_quran_repository/mq_quran_repository.dart';

class QuranCubit extends Cubit<int> {
  QuranCubit({required this.mqQuranRepository}) : super(0);

  final MqQuranRepository mqQuranRepository;

  void change(int? val) => emit(val ?? 0);

  List<JuzEntity> getJuz() {
    return mqQuranRepository.getJuzs();
  }

  List<SurahEntity> getSurah() {
    return mqQuranRepository.getSurahs();
  }
}
