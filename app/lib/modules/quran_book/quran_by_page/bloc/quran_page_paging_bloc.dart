import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:meta/meta.dart';
import 'package:mq_quran_repository/mq_quran_repository.dart';
import 'package:my_quran/core/core.dart';

part 'quran_page_paging_event.dart';
part 'quran_page_paging_state.dart';

class QuranPagePagingBloc extends Bloc<QuranPagePagingEvent, QuranPagePagingState> {
  QuranPagePagingBloc({
    required this.repository,
    required this.pagesNumber,
  }) : super(QuranPagePagingState()) {
    on<QuranPagePagingFetchNex>(_onQuranPagePagingFetchNex);
    on<QuranPagePagingRefresh>(_onQuranPagePagingRefresh);
    on<QuranPagePagingCancel>(_onQuranPagePagingCancel);
  }

  final MqQuranRepository repository;
  final List<int> pagesNumber;

  Future<List<QuranDataEntity>> _fetchItem(
    int pageNumber,
    String quranFmt,
  ) async {
    final res = await repository.fetchQuranByPage(
      pageNumber,
      quranFmt,
    );
    return [res];
  }

  FutureOr<void> _onQuranPagePagingFetchNex(
    QuranPagePagingFetchNex event,
    Emitter<QuranPagePagingState> emit,
  ) async {
    final current = state;
    if (current.isLoading || !current.hasNextPage) return;

    final pageKey = current.lastPageIsEmpty ? null : current.nextIntPageKey;
    if (!pagesNumber.contains(event.pageNumber) || pageKey == null) {
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
      final result = await _fetchItem(
        event.pageNumber,
        event.quranFmt,
      );

      if (cancelToken.isCancelled) return;

      final isLastPage = event.pageNumber == pagesNumber.last;
      emit(
        state.copyWith(
          isLoading: false,
          error: null,
          hasNextPage: !isLastPage,
          pages: [...?state.pages, result],
          keys: [...?state.keys, pageKey],
          cancelToken: null,
          index: (state.index ?? 0) + 1,
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

  FutureOr<void> _onQuranPagePagingRefresh(
    QuranPagePagingRefresh event,
    Emitter<QuranPagePagingState> emit,
  ) {
    state.cancelToken?.cancel();
    emit(state.reset());
    final nextEvent = QuranPagePagingFetchNex(
      pageNumber: event.pageNumber,
      quranFmt: event.quranFmt,
    );
    add(nextEvent);
  }

  FutureOr<void> _onQuranPagePagingCancel(
    QuranPagePagingCancel event,
    Emitter<QuranPagePagingState> emit,
  ) {
    state.cancelToken?.cancel();
    emit(
      state.copyWith(
        isLoading: false,
        cancelToken: null,
      ),
    );
  }

  @override
  Future<void> close() {
    state.cancelToken?.cancel();
    return super.close();
  }
}
