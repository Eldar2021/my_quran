import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';

import 'package:hatim/constants/contants.dart';
import 'package:hatim/models/hatim/hatim_juz.dart';
import 'package:stomp_dart_client/stomp_frame.dart';

part 'hatim_juz_state.dart';

class HatimJuzCubit extends Cubit<HatimJuzState> {
  HatimJuzCubit() : super(const HatimJuzState());

  late StompClient client;

  dynamic connect(String hatimId, String token) {
    client = StompClient(
      config: StompConfig(
        url: ApiConst.socketBase,
        onStompError: onStompError,
        onWebSocketError: onWebSocketError,
        onConnect: (event) => onConnect(hatimId, token),
      ),
    );

    client.activate();
  }

  void onStompError(StompFrame e) {
    if (!isClosed) emit(HatimJuzState(erorText: 'Hatim Error $e'));
  }

  void onWebSocketError(dynamic e) {
    if (!isClosed) emit(HatimJuzState(erorText: 'Hatim Error $e'));
  }

  void callback(StompFrame event) {
    if (event.body != null) {
      final data = jsonDecode(event.body!) as List<dynamic>;
      final items = data.map((e) => HatimJus.fromJson(e as Map<String, dynamic>)).toList();
      if (!isClosed) emit(HatimJuzState(hatimJuzs: items));
    } else {
      if (!isClosed) emit(const HatimJuzState(erorText: 'Some Error'));
    }
  }

  void onConnect(String hatimId, String token) {
    client.subscribe(
      destination: ApiConst.juzSocket(hatimId),
      headers: ApiConst.authMap(token),
      callback: callback,
    );
  }
}
