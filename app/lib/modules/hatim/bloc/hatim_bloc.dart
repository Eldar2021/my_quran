import 'dart:async';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:mq_crashlytics/mq_crashlytics.dart';
import 'package:mq_hatim_repository/mq_hatim_repository.dart';

part 'hatim_event.dart';
part 'hatim_state.dart';
part 'hatim_state_dashboard.dart';
part 'hatim_state_juzs.dart';
part 'hatim_state_juz_pages.dart';
part 'hatim_state_user_pages.dart';

class HatimBloc extends Bloc<HatimEvent, HatimState> {
  HatimBloc({required this.repo, required this.token}) : super(const HatimState()) {
    on<GetInitailDataEvent>(_onGetInitailDataEvent);
    on<GetHatimJuzPagesEvent>(_onGetHatimJuzPagesEvent);
    on<SelectPageEvent>(_onSelectPageEvent);
    on<UnSelectPageEvent>(_onUnSelectPageEvent);
    on<SetInProgressPagesEvent>(_onSetInProgressPagesEvent);
    on<SetDonePagesEvent>(_onSetDonePagesEvent);
    on<ResetJuzPagesEvent>(_onResetJuzPagesEvent);
    on<ReceidevBaseDataEvent>(_onReceidevBaseDataEvent);
  }

  final MqHatimRepository repo;
  final String token;
  bool islistened = false;

  FutureOr<void> _onGetInitailDataEvent(GetInitailDataEvent event, Emitter<HatimState> emit) async {
    try {
      if (state.dashBoardState is HatimDashBoardLoading) return;
      emit(state.copyWith(dashBoardState: const HatimDashBoardLoading()));
      final data = await repo.getHatim();
      emit(state.copyWith(dashBoardState: HatimDashBoardFetched(data)));

      emit(state.copyWith(eventState: const HatimStateLoading()));
      repo.connectToSocket(token);
      if (!islistened) {
        repo.stream.listen((v) => add(ReceidevBaseDataEvent(v)));
        islistened = true;
      }

      emit(state.copyWith(eventState: HatimStateSuccess(data.id)));

      emit(state.copyWith(juzsState: const HatimJuzsLoading()));
      repo.sinkHatimJuzs(data.id);

      emit(state.copyWith(userPagesState: const HatimUserPagesLoading()));
      repo.sinkHatimUserPages();
    } on Exception catch (e, s) {
      MqCrashlytics.report(e, s);
      log('_onGetHatimDashBoardEvent: $e\n$s');
      emit(state.copyWith(dashBoardState: HatimDashBoardFailed(Exception(e))));
    }
  }

  FutureOr<void> _onGetHatimJuzPagesEvent(GetHatimJuzPagesEvent event, Emitter<HatimState> emit) async {
    if (state.juzPagesState is HatimJuzPagesLoading) return;
    emit(state.copyWith(juzPagesState: const HatimJuzPagesLoading()));
    repo.sinkHatimJuzPages(event.juzId);
  }

  FutureOr<void> _onSelectPageEvent(SelectPageEvent event, Emitter<HatimState> emit) async {
    repo.sinkSelectPage(event.pageId);
  }

  FutureOr<void> _onUnSelectPageEvent(UnSelectPageEvent event, Emitter<HatimState> emit) async {
    repo.sinkUnSelectPage(event.pageId);
  }

  FutureOr<void> _onSetInProgressPagesEvent(SetInProgressPagesEvent event, Emitter<HatimState> emit) async {
    repo.sinkInProgressPages(event.pageIds);
  }

  FutureOr<void> _onSetDonePagesEvent(SetDonePagesEvent event, Emitter<HatimState> emit) async {
    repo.sinkDonePages(event.pageIds);
  }

  FutureOr<void> _onResetJuzPagesEvent(ResetJuzPagesEvent event, Emitter<HatimState> emit) {
    emit(state.copyWith(juzPagesState: const HatimJuzPagesInitial()));
  }

  FutureOr<void> _onReceidevBaseDataEvent(ReceidevBaseDataEvent event, Emitter<HatimState> emit) {
    final src = event.data;
    final newState = switch (src.$1) {
      HatimResponseType.listOfJuz => state.copyWith(juzsState: HatimJuzsFetched(src.$2 as List<MqHatimJusEntity>)),
      HatimResponseType.listOfPage => state.copyWith(
        juzPagesState: HatimJuzPagesFetched(src.$2 as List<MqHatimPagesEntity>),
      ),
      HatimResponseType.userPages => state.copyWith(
        userPagesState: HatimUserPagesFetched(src.$2 as List<MqHatimPagesEntity>),
      ),
    };

    emit(newState);
  }

  @override
  Future<void> close() {
    repo.close();
    return super.close();
  }
}
