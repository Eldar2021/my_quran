import 'dart:convert';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatim/constants/contants.dart';
import 'package:hatim/core/core.dart';

import 'package:hatim/models/models.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';

part 'hatim_juz_state.dart';

class HatimJuzCubit extends Cubit<HatimJuzState> {
  HatimJuzCubit(this.juzNumber) : super(const HatimJuzState());

  final int juzNumber;

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
    if (!isClosed) emit(const HatimJuzState(status: FetchStatus.error));
  }

  void onWebSocketError(dynamic e) {
    if (!isClosed) emit(const HatimJuzState(status: FetchStatus.error));
  }

  void callback(StompFrame event) {
    if (event.body != null) {
      log('body body ${event.body}');
      final data = jsonDecode(event.body!) as List<dynamic>;
      final items = data.map((e) => HatimPages.fromJson(e as Map<String, dynamic>)).toList();
      if (!isClosed) emit(HatimJuzState(pages: items, status: FetchStatus.success));
    } else {
      if (!isClosed) emit(const HatimJuzState(status: FetchStatus.success));
    }
  }

  void onConnect(String juzId, String token) {
    client.subscribe(
      destination: ApiConst.getPagesByJuz(juzId),
      headers: ApiConst.authMap(token),
      callback: callback,
    );
  }

  void selectPage(String pageId, String token, String username) {
    client.send(
      destination: ApiConst.setBook,
      headers: ApiConst.authMap(token),
      body: jsonEncode({'pageId': pageId, 'username': username}),
    );
  }
}
