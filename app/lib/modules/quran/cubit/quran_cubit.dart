import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mq_quran_repository/mq_quran_repository.dart';

class QuranCubit extends Cubit<int> {
  QuranCubit({required this.mqQuranRepository}) : super(0);

  final MqQuranRepository mqQuranRepository;

  void change(int? val) => emit(val ?? 0);

  List<MqJuzEntity> getJuz() {
    return mqQuranRepository.getJuzsData();
  }

  List<MqSurahEntity> getSurah() {
    return mqQuranRepository.getSurahsData();
  }
}
