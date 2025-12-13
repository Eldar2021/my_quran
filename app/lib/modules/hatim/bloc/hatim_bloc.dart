import 'dart:async';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:mq_hatim_repository/mq_hatim_repository.dart';
import 'package:my_quran/modules/modules.dart';

part 'hatim_event.dart';
part 'hatim_state.dart';
part 'hatim_state_juzs.dart';
part 'hatim_state_juz_pages.dart';
part 'hatim_state_user_pages.dart';

class HatimBloc extends Bloc<HatimEvent, HatimState> with ParseHatimDataMixin {
  HatimBloc({
    required this.socket,
    required this.token,
    required this.hatimId,
  }) : super(const HatimState()) {
    on<GetInitialDataEvent>(_onGetInitailDataEvent);
    on<DisconnectSocketEvent>(_onDisconnectSocketEvent);
    on<HatimConnectionChangedEvent>(_onHatimConnectionChangedEvent);
    on<GetHatimJuzPagesEvent>(_onGetHatimJuzPagesEvent);
    on<SelectPageEvent>(_onSelectPageEvent);
    on<UnSelectPageEvent>(_onUnSelectPageEvent);
    on<SetInProgressPagesEvent>(_onSetInProgressPagesEvent);
    on<SetDonePagesEvent>(_onSetDonePagesEvent);
    on<ResetJuzPagesEvent>(_onResetJuzPagesEvent);
    on<ReceivedBaseDataEvent>(_onReceidevBaseDataEvent);
  }

  final MqHatimSocket socket;
  final String hatimId;
  final String token;

  StreamSubscription<ConnectionState>? _connectionSubscription;
  StreamSubscription<dynamic>? _messageSubscription;

  FutureOr<void> _onGetInitailDataEvent(
    GetInitialDataEvent event,
    Emitter<HatimState> emit,
  ) async {
    socket.connectToSocket(token);

    await _connectionSubscription?.cancel();
    await _messageSubscription?.cancel();
    _connectionSubscription = null;
    _messageSubscription = null;
    _connectionSubscription = socket.connectionStream.listen((connectionState) {
      log('connectionState: $connectionState');
      add(HatimConnectionChangedEvent(connectionState));
    });

    _messageSubscription = socket.messages.listen((v) {
      add(ReceivedBaseDataEvent(parseHatimData(v)));
    });

    emit(state.copyWith(userPagesState: const HatimUserPagesLoading()));
  }

  FutureOr<void> _onHatimConnectionChangedEvent(
    HatimConnectionChangedEvent event,
    Emitter<HatimState> emit,
  ) {
    emit(state.copyWith(connectionState: event.connectionState));

    if (event.connectionState is Connected || event.connectionState is Reconnected) {
      log('sinkHatimJuzs=$hatimId');
      socket
        ..sinkHatimJuzs(hatimId)
        ..sinkHatimUserPages();
    }
  }

  FutureOr<void> _onDisconnectSocketEvent(
    DisconnectSocketEvent event,
    Emitter<HatimState> emit,
  ) async {
    socket.close();

    await _connectionSubscription?.cancel();
    _connectionSubscription = null;
    await _messageSubscription?.cancel();
    _messageSubscription = null;

    emit(state.copyWith(connectionState: const Disconnected()));
  }

  FutureOr<void> _onGetHatimJuzPagesEvent(
    GetHatimJuzPagesEvent event,
    Emitter<HatimState> emit,
  ) async {
    emit(state.copyWith(juzPagesState: const HatimJuzPagesLoading()));
    socket.sinkHatimJuzPages(event.juzId);
  }

  FutureOr<void> _onSelectPageEvent(
    SelectPageEvent event,
    Emitter<HatimState> emit,
  ) async {
    socket.sinkSelectPage(event.pageId);
  }

  FutureOr<void> _onUnSelectPageEvent(
    UnSelectPageEvent event,
    Emitter<HatimState> emit,
  ) async {
    socket.sinkUnSelectPage(event.pageId);
  }

  FutureOr<void> _onSetInProgressPagesEvent(
    SetInProgressPagesEvent event,
    Emitter<HatimState> emit,
  ) async {
    socket.sinkInProgressPages(event.pageIds);
  }

  FutureOr<void> _onSetDonePagesEvent(
    SetDonePagesEvent event,
    Emitter<HatimState> emit,
  ) async {
    socket.sinkDonePages(event.pageIds);
  }

  FutureOr<void> _onResetJuzPagesEvent(
    ResetJuzPagesEvent event,
    Emitter<HatimState> emit,
  ) {
    emit(state.copyWith(juzPagesState: const HatimJuzPagesInitial()));
  }

  FutureOr<void> _onReceidevBaseDataEvent(
    ReceivedBaseDataEvent event,
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

  @override
  Future<void> close() {
    _connectionSubscription?.cancel();
    _messageSubscription?.cancel();
    socket.close();
    return super.close();
  }
}
