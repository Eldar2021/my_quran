import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_quran/core/core.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationGlobalState> {
  NotificationCubit(this.repository) : super(const NotificationGlobalState());

  final NotificationRepository repository;

  Future<void> getNotification(String? locale) async {
    try {
      final result = await repository.getNotifications(locale);
      emit(state.copyWith(fetchState: NotificationSuccess(result)));
    } on Object catch (e) {
      emit(state.copyWith(fetchState: NotificationError(e)));
    }
  }

  Future<void> toggleNotification({
    required String userToken,
    bool value = true,
  }) async {
    try {
      emit(state.copyWith(permissionState: const NotificationPermissionLoading()));
      await repository.toggleNotification(
        userToken: userToken,
        value: value,
      );
      final newFetchState = NotificationPermissionSuccess(isEnabled: value);
      emit(state.copyWith(permissionState: newFetchState));
    } on Object catch (e, s) {
      log('toggleNotification', error: e, stackTrace: s);
      emit(state.copyWith(permissionState: NotificationPermissionError(e)));
    }
  }
}
