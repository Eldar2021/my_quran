import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:mq_quran_repository/mq_quran_repository.dart';

part 'quran_read_state.dart';

class ReadCubit extends Cubit<ReadState> {
  ReadCubit(this.mqQuranRepository) : super(const ReadState());

  final MqQuranRepository mqQuranRepository;

  Future<QuranPageEntity?> fetchQuranPage(int page) async {
    return mqQuranRepository.getPage(page, state.fmt.name);
  }
}
