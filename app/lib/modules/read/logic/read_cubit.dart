import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:my_quran/models/models.dart';
import 'package:my_quran/modules/read/read.dart';

part 'read_state.dart';

class ReadCubit extends Cubit<ReadState> {
  ReadCubit(this.repo, this.pages) : super(const ReadState());

  final ReadService repo;
  final List<int> pages;

  Future<QuranPage?> getPage(int page) async {
    return repo.gerVerses(page, state.fmt.name);
  }
}
