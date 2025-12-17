import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:mq_auth_repository/mq_auth_repository.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit(this.repository) : super(const NotificationInitial());

  final AuthRepository repository;

  Future<void> getNotification(
    String locale,
    String userId,
  ) async {
    try {
      final result = await repository.getNotifications(
        locale,
        userId,
      );
      emit(NotificationSuccess(result));
    } on Object catch (e) {
      log('getNotification', error: e);
      emit(NotificationError(e));
    }
  }
}
