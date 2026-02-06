import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:mq_auth_repository/mq_auth_repository.dart';

part 'user_rating_main_state.dart';

class UserRatingMainCubit extends Cubit<UserRatingMainState> {
  UserRatingMainCubit(this.repository) : super(const UserRatingMainInitial());

  final AuthRepository repository;

  Future<void> getUserRatingMain(String userId) async {
    emit(const UserRatingMainLoading());
    try {
      final result = await repository.getUserRatingMain(userId);
      emit(UserRatingMainSuccess(result));
    } on Object catch (e) {
      emit(UserRatingMainError(e));
    }
  }
}
