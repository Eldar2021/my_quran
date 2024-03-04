import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_quran/modules/modules.dart';

part 'read_state.dart';

class ReadCubit extends Cubit<ReadState> {
  ReadCubit(this.getQuranPageUseCase) : super(const ReadState());

  final GetReadPageUseCase getQuranPageUseCase;

  Future<QuranPage?> fetchQuranPage(int page) async {
    return getQuranPageUseCase.getPage(page, state.fmt.name);
  }
}
