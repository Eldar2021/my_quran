import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_quran/config/config.dart';
import 'package:my_quran/core/core.dart';
import 'package:my_quran/modules/hatim/hatim.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

part 'hatim_event.dart';
part 'hatim_state.dart';
part 'hatim_state_dashboard.dart';
part 'hatim_state_juzs.dart';
part 'hatim_state_juz_pages.dart';
part 'hatim_state_user_pages.dart';

class HatimBloc extends Bloc<HatimEvent, HatimState> {
  HatimBloc({
    required this.remoteClient,
    required this.token,
  }) : super(const HatimState()) {
    on<GetHatimDashBoardEvent>(_onGetHatimDashBoardEvent);
    on<ConnectToHatimdEvent>(_onConnectToHatimdEvent);
    on<GetHatimJuzsEvent>(_onGetHatimJuzsEvent);
    on<GetHatimUserPagesEvent>(_onGetHatimUserPagesEvent);
    on<GetHatimJuzPagesEvent>(_onGetHatimJuzPagesEvent);
    on<SelectPageEvent>(_onSelectPageEvent);
    on<UnSelectPageEvent>(_onUnSelectPageEvent);
    on<SetInProgressPagesEvent>(_onSetInProgressPagesEvent);
    on<SetDonePagesEvent>(_onSetDonePagesEvent);
    on<ReceidevBaseDataEvent>(_onReceidevBaseDataEvent);
    on<ReceidevJuzsDataEvent>(_onReceidevJuzsDataEvent);
    on<ReceidevUserPagesEvent>(_onReceidevUserPagesEvent);
    on<ReceidevJuzPagesEvent>(_onReceidevJuzPagesEvent);
    on<ResetJuzPagesEvent>(_onResetJuzPagesEvent);
  }

  final RemoteClient remoteClient;
  final String token;

  late WebSocketChannel channel;

  FutureOr<void> _onGetHatimDashBoardEvent(
    GetHatimDashBoardEvent event,
    Emitter<HatimState> emit,
  ) async {
    final dashBoardState = state.dashBoardState;
    if (dashBoardState is HatimDashBoardLoading) return;
    emit(state.copyWith(dashBoardState: const HatimDashBoardLoading()));
    try {
      final data = await remoteClient.post(
        apiConst.joinToHatim,
        fromJson: HatimReadModel.fromJson,
        token: token,
      );

      data.fold(
        (l) {
          log('_onGetHatimDashBoardEvent: $l');
          emit(state.copyWith(dashBoardState: HatimDashBoardFailed(l)));
        },
        (r) {
          emit(state.copyWith(dashBoardState: HatimDashBoardFetched(r)));
        },
      );
    } catch (e, s) {
      log('_onGetHatimDashBoardEvent: $e\n$s');
      emit(state.copyWith(dashBoardState: HatimDashBoardFailed(Exception(e))));
    }
  }

  FutureOr<void> _onConnectToHatimdEvent(
    ConnectToHatimdEvent event,
    Emitter<HatimState> emit,
  ) async {
    final eventState = state.eventState;
    if (eventState is HatimStateLoading) return;
    try {
      if (eventState is HatimStateInitial) {
        channel = WebSocketChannel.connect(
          Uri.parse('wss://myquran.life/ws/?token=$token'),
        );

        emit(state.copyWith(eventState: HatimStateSuccess(event.hatimId)));

        channel.stream.listen(
          (event) async {
            // log(event.toString());
            final src = HatimBaseResponse.fromJson(
              jsonDecode(event as String) as Map<String, dynamic>,
            );
            add(ReceidevBaseDataEvent(src));
          },
          onError: (Object e) async {
            log('_onConnectToHatimdEvent listen onError $e');
          },
          onDone: () async {
            log('_onConnectToHatimdEvent listen onDone');
          },
          cancelOnError: true,
        );
      }
    } catch (e, s) {
      log('_onConnectToHatimdEvent: $e\n$s');
      emit(state.copyWith(eventState: HatimStateFailed(Exception(e))));
    }
  }

  FutureOr<void> _onReceidevBaseDataEvent(
    ReceidevBaseDataEvent event,
    Emitter<HatimState> emit,
  ) async {
    final data = event.data.data as List<dynamic>;
    return switch (event.data.type) {
      HatimResponseType.listOfJuz => add(ReceidevJuzsDataEvent(data)),
      HatimResponseType.listOfPage => add(ReceidevJuzPagesEvent(data)),
      HatimResponseType.userPages => add(ReceidevUserPagesEvent(data)),
    };
  }

  FutureOr<void> _onReceidevUserPagesEvent(
    ReceidevUserPagesEvent event,
    Emitter<HatimState> emit,
  ) async {
    try {
      final data = event.data.map((e) => HatimPages.fromJson(e as Map<String, dynamic>)).toList();
      emit(state.copyWith(userPagesState: HatimUserPagesFetched(data)));
    } catch (e, s) {
      log('_receivedUserPages: $e\n$s');
      emit(state.copyWith(userPagesState: HatimUserPagesFailed(Exception(e))));
    }
  }

  Future<void> _onReceidevJuzPagesEvent(
    ReceidevJuzPagesEvent event,
    Emitter<HatimState> emit,
  ) async {
    try {
      final data = event.data.map((e) => HatimPages.fromJson(e as Map<String, dynamic>)).toList();
      emit(state.copyWith(juzPagesState: HatimJuzPagesFetched(data)));
    } catch (e, s) {
      log('_receivedJuzPages: $e\n$s');
      emit(state.copyWith(juzPagesState: HatimJuzPagesFailed(Exception(e))));
    }
  }

  FutureOr<void> _onReceidevJuzsDataEvent(
    ReceidevJuzsDataEvent event,
    Emitter<HatimState> emit,
  ) async {
    try {
      final data = event.data.map((e) => HatimJus.fromJson(e as Map<String, dynamic>)).toList();
      emit(state.copyWith(juzsState: HatimJuzsFetched(data)));
    } catch (e, s) {
      log('_receivedJuzsData: $e\n$s');
      emit(state.copyWith(juzsState: HatimJuzsFailed(Exception(e))));
    }
  }

  FutureOr<void> _onGetHatimJuzsEvent(
    GetHatimJuzsEvent event,
    Emitter<HatimState> emit,
  ) async {
    if (state.juzsState is HatimJuzsLoading) return;
    try {
      emit(state.copyWith(juzsState: const HatimJuzsLoading()));
      final data = {
        'type': 'list_of_juz',
        'hatim_id': event.hatimId,
      };
      channel.sink.add(json.encode(data));
    } catch (e, s) {
      log('_onGetHatimJuzsEvent: $e\n$s');
      emit(state.copyWith(juzsState: HatimJuzsFailed(Exception(e))));
    }
  }

  FutureOr<void> _onGetHatimUserPagesEvent(
    GetHatimUserPagesEvent event,
    Emitter<HatimState> emit,
  ) async {
    if (state.userPagesState is HatimUserPagesLoading) return;
    try {
      emit(state.copyWith(userPagesState: const HatimUserPagesLoading()));
      final data = {
        'type': 'user_pages',
      };
      channel.sink.add(jsonEncode(data));
    } catch (e, s) {
      log('_onGetHatimUserPagesEvent: $e\n$s');
      emit(state.copyWith(userPagesState: HatimUserPagesFailed(Exception(e))));
    }
  }

  FutureOr<void> _onGetHatimJuzPagesEvent(
    GetHatimJuzPagesEvent event,
    Emitter<HatimState> emit,
  ) async {
    if (state.juzPagesState is HatimJuzPagesLoading) return;
    try {
      emit(state.copyWith(juzPagesState: const HatimJuzPagesLoading()));
      final data = {
        'type': 'list_of_page',
        'juz_id': event.juzId,
      };
      channel.sink.add(jsonEncode(data));
    } catch (e, s) {
      log('_onGetHatimJuzPagesEvent: $e\n$s');
      emit(state.copyWith(juzPagesState: HatimJuzPagesFailed(Exception(e))));
    }
  }

  FutureOr<void> _onSelectPageEvent(
    SelectPageEvent event,
    Emitter<HatimState> emit,
  ) async {
    try {
      final data = {
        'type': 'book',
        'pageId': event.pageId,
      };
      channel.sink.add(jsonEncode(data));
    } catch (e, s) {
      log('_onSelectPageEvent: $e\n$s');
      emit(state.copyWith(userPagesState: HatimUserPagesFailed(Exception(e))));
    }
  }

  FutureOr<void> _onUnSelectPageEvent(
    UnSelectPageEvent event,
    Emitter<HatimState> emit,
  ) async {
    try {
      final data = {
        'type': 'to_do',
        'pageId': event.pageId,
      };
      channel.sink.add(jsonEncode(data));
    } catch (e, s) {
      log('_onUnSelectPageEvent: $e\n$s');
      emit(state.copyWith(userPagesState: HatimUserPagesFailed(Exception(e))));
    }
  }

  FutureOr<void> _onSetInProgressPagesEvent(
    SetInProgressPagesEvent event,
    Emitter<HatimState> emit,
  ) async {
    try {
      final data = {
        'type': 'in_progress',
        'pageIds': event.pageIds,
      };
      channel.sink.add(jsonEncode(data));
    } catch (e, s) {
      log('_onSetInProgressPagesEvent: $e\n$s');
      emit(state.copyWith(userPagesState: HatimUserPagesFailed(Exception(e))));
    }
  }

  FutureOr<void> _onSetDonePagesEvent(
    SetDonePagesEvent event,
    Emitter<HatimState> emit,
  ) async {
    try {
      final data = {
        'type': 'done',
        'pageIds': event.pageIds,
      };
      channel.sink.add(jsonEncode(data));
    } catch (e, s) {
      log('_onSetDonePagesEvent: $e\n$s');
      emit(state.copyWith(userPagesState: HatimUserPagesFailed(Exception(e))));
    }
  }

  FutureOr<void> _onResetJuzPagesEvent(
    ResetJuzPagesEvent event,
    Emitter<HatimState> emit,
  ) {
    emit(state.copyWith(juzPagesState: const HatimJuzPagesInitial()));
  }
}
