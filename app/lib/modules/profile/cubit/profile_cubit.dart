import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:mq_auth_repository/mq_auth_repository.dart';

part 'profile_state.dart';
part 'profile_loading_type.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this.repository) : super(const ProfileInitial());

  final AuthRepository repository;

  Future<void> getUserData(String userId) async {
    emit(const ProfileLoading(ProfileLoadingType.initial));
    try {
      final user = await repository.getUserData(userId);
      emit(ProfileSuccess(AuthModel(user: user, key: userId)));
    } on Object catch (e) {
      emit(ProfileError(e));
    }
  }

  Future<void> updateUserData(UpdateUserDataParam param) async {
    emit(ProfileLoading(ProfileLoadingType.fromUpdateValueType(param)));
    try {
      final res = await repository.patchUserData(param);
      emit(ProfileSuccess(AuthModel(key: param.userId, user: res)));
    } on Object catch (e) {
      emit(ProfileError(e));
    }
  }

  Future<void> logout() async {
    emit(const ProfileLoading(ProfileLoadingType.logout));
    try {
      await repository.logout();
      emit(const ProfileLogout());
    } on Exception catch (e) {
      emit(ProfileError(e));
    }
  }

  Future<void> deleteAccount() async {
    emit(const ProfileLoading(ProfileLoadingType.deleteAccount));
    try {
      await repository.deleteAccount();
      emit(const ProfileDeleted());
    } on Exception catch (e) {
      emit(ProfileError(e));
    }
  }

  void setAuth(AuthModel auth) {
    emit(ProfileSuccess(auth));
  }
}
