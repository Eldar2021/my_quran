import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatim/models/models.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<int> {
  HomeCubit() : super(0);

  void change(int? val) => emit(val ?? 0);

  final List<Juz> juzs = juzData.map(Juz.fromMap).toList();

  final List<Surah> surahs = surahData.map(Surah.fromMap).toList();
}
