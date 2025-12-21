import 'dart:developer';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:mq_auth_repository/mq_auth_repository.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit(this.repository) : super(const NotificationState());

  final AuthRepository repository;

  Future<void> getNotification(
    String? locale,
    String? userId,
    NotificationModel? data,
  ) async {
    if (data != null) {
      emit(state.copyWith(fetchState: NotificationHasInitialData(data)));
    }
    try {
      if (userId == null && data == null) {
        emit(state.copyWith(fetchState: const NotificationFetchSuccess([])));
        return;
      } else if (userId != null) {
        final result = await repository.getNotifications(
          locale ?? 'en',
          userId,
        );
        emit(state.copyWith(fetchState: NotificationFetchSuccess(result)));
      }
    } on Object catch (e) {
      log('getNotification', error: e);
      emit(state.copyWith(fetchState: NotificationFetchError(e)));
    }
  }

  Future<void> setNotificationToken({
    required AuthModel auth,
    required String fcmToken,
    required String deviceId,
    required String deviceTimezone,
  }) async {
    emit(state.copyWith(tokenState: const NotificationTokenLoading()));
    try {
      await repository.setNotificationToken(
        userId: auth.key,
        notificationToken: fcmToken,
        deviceType: Platform.isAndroid ? 'android' : 'ios',
        deviceId: deviceId,
        deviceTimezone: deviceTimezone,
      );
      emit(
        state.copyWith(
          tokenState: NotificationTokenSuccess(fcmToken),
          allowedState: const NotificationAllowedSuccess(true),
        ),
      );
    } on Object catch (e) {
      log('setNotificationToken', error: e);
      emit(
        state.copyWith(
          tokenState: NotificationTokenError(e),
          allowedState: const NotificationAllowedSuccess(false),
        ),
      );
    }
  }

  Future<void> toggleNotification(
    String userId,
    bool value,
  ) async {
    emit(state.copyWith(allowedState: NotificationAllowedLoading(value)));
    try {
      final res = await repository.patchUserData(
        NotificationEnabledParam(userId: userId, enabled: value),
      );
      emit(
        state.copyWith(
          allowedState: NotificationAllowedSuccess(res.allowNotifications ?? value),
        ),
      );
    } on Exception catch (e) {
      log('toggleNotification', error: e);
      emit(
        state.copyWith(
          allowedState: NotificationAllowedError(
            state.allowedState.value,
            e,
          ),
        ),
      );
    }
  }
}
