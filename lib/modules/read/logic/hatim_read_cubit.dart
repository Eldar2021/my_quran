// import 'package:equatable/equatable.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import 'package:hatim/modules/modules.dart';

// part 'hatim_read_state.dart';

// class HatimReadCubit extends Cubit<HatimReadState> {
//   HatimReadCubit(this.storage) : super(const HatimReadState());
//   final PageStorage storage;

//   List<int> _pages = [];

//   void init() {
//     _pages = storage.getPages() ?? <int>[];
//     emit(state.copyWith(pages: _pages));
//   }

//   Future<void> setPages(int newPage) async {
//     _pages.add(newPage);
//     await storage.setPages(_pages);
//     emit(state.copyWith(pages: _pages));
//   }
// }
