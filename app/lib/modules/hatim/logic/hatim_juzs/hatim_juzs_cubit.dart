import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_quran/app_imports.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';


part 'hatim_juzs_state.dart';

class HatimJuzsCubit extends Cubit<HatimJuzsState> {
  HatimJuzsCubit() : super(const HatimJuzsState());

  late StompClient client;

  dynamic connect(String hatimId, String token) {
    client = StompClient(
      config: StompConfig(
        url: apiConst.baseSocket,
        onStompError: onStompError,
        onWebSocketError: onWebSocketError,
        onConnect: (event) => onConnect(hatimId, token),
      ),
    );

    client.activate();
  }

  void onStompError(StompFrame e) {
    if (!isClosed) emit(HatimJuzsState(erorText: 'Hatim Error $e'));
  }

  void onWebSocketError(dynamic e) {
    if (!isClosed) emit(HatimJuzsState(erorText: 'Hatim Error $e'));
  }

  void callback(StompFrame event) {
    if (event.body != null) {
      final data = jsonDecode(event.body!) as List<dynamic>;
      final items = data.map((e) => HatimJus.fromJson(e as Map<String, dynamic>)).toList();
      if (!isClosed) emit(HatimJuzsState(hatimJuzs: items));
    } else {
      if (!isClosed) emit(const HatimJuzsState(erorText: 'Some Error'));
    }
  }

  void onConnect(String hatimId, String token) {
    client.subscribe(
      destination: apiConst.juzSocket(hatimId),
      headers: apiConst.authMap(token),
      callback: callback,
    );
  }

  @override
  Future<void> close() {
    client.deactivate();
    return super.close();
  }
}
