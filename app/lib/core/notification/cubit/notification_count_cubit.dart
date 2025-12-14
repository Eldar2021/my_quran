import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'notification_count_state.dart';

class NotificationCountCubit extends Cubit<NotificationCountState> {
  NotificationCountCubit() : super(const NotificationCountState());

  void increment() {
    emit(state.copyWith(notificationCount: state.notificationCount + 1));
  }

  void decrement() {
    emit(state.copyWith(notificationCount: state.notificationCount - 1));
  }

  void toggleNotification({bool value = true}) {
    emit(state.copyWith(isNotificationEnabled: value));
  }

  void reset() {
    emit(const NotificationCountState());
  }
}
