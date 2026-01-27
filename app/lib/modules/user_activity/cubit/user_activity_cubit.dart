import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:mq_auth_repository/mq_auth_repository.dart';

part 'user_activity_state.dart';

class UserActivityCubit extends Cubit<UserActivityState> {
  UserActivityCubit(this._authRepository) : super(const UserActivityInitial());

  final AuthRepository _authRepository;

  Future<void> loadActivities(String userId) async {
    emit(const UserActivityLoading());
    try {
      final activities = await _authRepository.getUserActivity(userId);
      emit(UserActivityLoaded(activities));
      // await Future<void>.delayed(const Duration(seconds: 1));
      // emit(const UserActivityError('Erro'));
    } on Object catch (e) {
      emit(UserActivityError(e));
    }
  }

  void setUnauthorized() {
    emit(const UserActivityUnauthorized());
  }
}
