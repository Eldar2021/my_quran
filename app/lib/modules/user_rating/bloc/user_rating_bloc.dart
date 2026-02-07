import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:meta/meta.dart';
import 'package:mq_auth_repository/mq_auth_repository.dart';
import 'package:my_quran/core/core.dart';

part 'user_rating_event.dart';
part 'user_rating_state.dart';

class UserRatingBloc extends Bloc<UserRatingEvent, UserRatingState> {
  UserRatingBloc({
    required this.repository,
    required this.userId,
    required this.areaType,
  }) : super(UserRatingState()) {
    on<UserRatingFetchNext>(_onUserRatingFetchNext);
    on<UserRatingRefresh>(_onUserRatingRefresh);
    on<UserRatingCancel>(_onUserRatingCancel);
  }

  final AuthRepository repository;
  final String userId;
  final AreaType areaType;

  Future<RatingResponseModel> _fetchItem(int pageNumber, PeriodType periodType) {
    return const AuthRepositoryMock().getRatingData(
      RatingRequestModel(
        userId: userId,
        periodType: periodType,
        areaType: areaType,
        page: pageNumber,
      ),
    );
  }

  FutureOr<void> _onUserRatingFetchNext(
    UserRatingFetchNext event,
    Emitter<UserRatingState> emit,
  ) async {
    final current = state;
    if (current.isLoading || !current.hasNextPage) return;

    final pageKey = current.lastPageIsEmpty ? null : current.nextIntPageKey;
    if (pageKey == null) {
      emit(current.copyWith(hasNextPage: false));
      return;
    }

    current.cancelToken?.cancel();
    final cancelToken = BlocCancelToken();

    emit(
      current.copyWith(
        isLoading: true,
        error: null,
        cancelToken: cancelToken,
      ),
    );

    try {
      final result = await _fetchItem(pageKey, event.periodType);
      if (cancelToken.isCancelled) return;

      emit(
        state.copyWith(
          isLoading: false,
          error: null,
          hasNextPage: result.pagination.hasNext,
          pages: [...?state.pages, result.list],
          keys: [...?state.keys, pageKey],
          cancelToken: null,
          index: (state.index ?? 0) + 1,
          ownerData: result.ownerData,
        ),
      );
    } on Exception catch (e) {
      if (!cancelToken.isCancelled) {
        emit(
          state.copyWith(
            isLoading: false,
            error: e,
            cancelToken: null,
          ),
        );
      }
    }
  }

  FutureOr<void> _onUserRatingRefresh(
    UserRatingRefresh event,
    Emitter<UserRatingState> emit,
  ) {
    state.cancelToken?.cancel();
    emit(state.reset());
    add(UserRatingFetchNext(event.periodType));
  }

  void _onUserRatingCancel(
    UserRatingCancel event,
    Emitter<UserRatingState> emit,
  ) {
    state.cancelToken?.cancel();
    emit(state.copyWith(isLoading: false, cancelToken: null));
  }

  @override
  Future<void> close() {
    state.cancelToken?.cancel();
    return super.close();
  }
}
