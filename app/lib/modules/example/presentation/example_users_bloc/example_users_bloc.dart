// ignore_for_file: avoid_catches_without_on_clauses

import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_quran/modules/example/example.dart';

part 'example_users_event.dart';
part 'example_users_state.dart';

class ExampleUsersBloc extends Bloc<ExampleUsersEvent, ExampleUsersState> {
  ExampleUsersBloc(this._repository) : super(const ExampleUsersInitial()) {
    on<ExampleUsersGetEvent>(_onExampleUsersGetEvent);
  }

  final ExampleRepository _repository;

  FutureOr<void> _onExampleUsersGetEvent(
    ExampleUsersGetEvent event,
    Emitter<ExampleUsersState> emit,
  ) async {
    try {
      emit(const ExampleUsersLoading());
      final data = await _repository.getUsers();
      emit(ExampleUsersSuccess(data));
    } catch (e) {
      emit(ExampleUsersError(e));
    }
  }
}
