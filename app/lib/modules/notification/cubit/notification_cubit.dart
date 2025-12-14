import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_quran/core/core.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit(this.repository) : super(const NotificationInitial());

  final NotificationRepository repository;

  Future<void> getNotification(String? locale) async {
    try {
      final result = await repository.getNotifications(locale);
      emit(NotificationSuccess(result));
    } on Object catch (e) {
      emit(NotificationError(e));
    }
  }
}
