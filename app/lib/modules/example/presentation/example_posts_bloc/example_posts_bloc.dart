// ignore_for_file: avoid_catches_without_on_clauses

import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_quran/modules/example/data/data.dart';
import 'package:my_quran/modules/example/domain/example_repository.dart';

part 'example_posts_event.dart';
part 'example_posts_state.dart';

class ExamplePostsBloc extends Bloc<ExamplePostsEvent, ExamplePostsState> {
  ExamplePostsBloc({
    required this.id,
    required this.repository,
  }) : super(const ExamplePostsInitial()) {
    on<ExamplePostsGetEvent>(_onExamplePostsGetEvent);
  }

  final int id;
  final ExampleRepository repository;

  FutureOr<void> _onExamplePostsGetEvent(
    ExamplePostsGetEvent event,
    Emitter<ExamplePostsState> emit,
  ) async {
    try {
      emit(const ExamplePostsLoading());
      final data = await repository.getPosts(id);
      emit(ExamplePostsSuccess(data));
    } catch (e) {
      emit(ExamplePostsError(e));
    }
  }
}
