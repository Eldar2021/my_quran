import 'dart:async';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:mq_hatim_repository/mq_hatim_repository.dart';

part 'hatim_event.dart';
part 'hatim_state.dart';
part 'hatim_state_juzs.dart';
part 'hatim_state_juz_pages.dart';
part 'hatim_state_user_pages.dart';

class HatimBloc extends Bloc<HatimEvent, HatimState> {
  HatimBloc({
    required this.repo,
    required this.token,
    required this.hatimId,
  }) : super(const HatimState()) {
    on<GetInitailDataEvent>(_onGetInitailDataEvent);
    on<GetHatimJuzPagesEvent>(_onGetHatimJuzPagesEvent);
    on<SelectPageEvent>(_onSelectPageEvent);
    on<UnSelectPageEvent>(_onUnSelectPageEvent);
    on<SetInProgressPagesEvent>(_onSetInProgressPagesEvent);
    on<SetDonePagesEvent>(_onSetDonePagesEvent);
    on<ResetJuzPagesEvent>(_onResetJuzPagesEvent);
    on<ReceidevBaseDataEvent>(_onReceidevBaseDataEvent);
    on<SetErrorStateEvent>(_onSetErrorStateEvent);
  }

  final MqHatimRepository repo;
  final String hatimId;
  final String token;
  bool islistened = false;

  FutureOr<void> _onGetInitailDataEvent(
    GetInitailDataEvent event,
    Emitter<HatimState> emit,
  ) async {
    repo.connectToSocket(token);
    if (!islistened) {
      repo.stream.listen(
        (v) => add(ReceidevBaseDataEvent(v)),
        onError: (Object e) {
          log(e.toString());
          emit(state.copyWith(juzsState: HatimJuzsFailed(Exception(e))));
        },
      );
      islistened = true;
    }
    repo.sinkHatimJuzs(hatimId);
    emit(state.copyWith(userPagesState: const HatimUserPagesLoading()));
    repo.sinkHatimUserPages();
  }

  void _onGetHatimJuzPagesEvent(
    GetHatimJuzPagesEvent event,
    Emitter<HatimState> emit,
  ) {
    if (state.juzPagesState is HatimJuzPagesLoading) return;
    emit(state.copyWith(juzPagesState: const HatimJuzPagesLoading()));
    repo.sinkHatimJuzPages(event.juzId);
  }

  void _onSelectPageEvent(
    SelectPageEvent event,
    Emitter<HatimState> emit,
  ) {
    repo.sinkSelectPage(event.pageId);
  }

  void _onUnSelectPageEvent(
    UnSelectPageEvent event,
    Emitter<HatimState> emit,
  ) {
    repo.sinkUnSelectPage(event.pageId);
  }

  void _onSetInProgressPagesEvent(
    SetInProgressPagesEvent event,
    Emitter<HatimState> emit,
  ) {
    repo.sinkInProgressPages(event.pageIds);
  }

  void _onSetDonePagesEvent(
    SetDonePagesEvent event,
    Emitter<HatimState> emit,
  ) {
    repo.sinkDonePages(event.pageIds);
  }

  void _onResetJuzPagesEvent(
    ResetJuzPagesEvent event,
    Emitter<HatimState> emit,
  ) {
    emit(
      state.copyWith(
        juzPagesState: const HatimJuzPagesInitial(),
      ),
    );
  }

  void _onReceidevBaseDataEvent(
    ReceidevBaseDataEvent event,
    Emitter<HatimState> emit,
  ) {
    final src = event.data;
    final newState = switch (src.$1) {
      HatimResponseType.listOfJuz => state.copyWith(
        juzsState: HatimJuzsFetched(src.$2 as List<MqHatimJusEntity>),
      ),
      HatimResponseType.listOfPage => state.copyWith(
        juzPagesState: HatimJuzPagesFetched(src.$2 as List<MqHatimPagesEntity>),
      ),
      HatimResponseType.userPages => state.copyWith(
        userPagesState: HatimUserPagesFetched(src.$2 as List<MqHatimPagesEntity>),
      ),
    };

    emit(newState);
  }

  void _onSetErrorStateEvent(
    SetErrorStateEvent event,
    Emitter<HatimState> emit,
  ) {
    repo.close();
    islistened = false;
    final exception = Exception(event.error);
    emit(state.copyWith(juzsState: HatimJuzsFailed(exception)));
  }

  @override
  Future<void> close() {
    repo.close();
    return super.close();
  }
}
