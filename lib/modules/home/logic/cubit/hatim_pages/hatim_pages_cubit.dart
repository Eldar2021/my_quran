import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';

import 'package:hatim/constants/contants.dart';

part 'hatim_pages_state.dart';

class HatimPagesCubit extends Cubit<HatimPagesState> {
  HatimPagesCubit() : super(const HatimPagesState());

  late StompClient client;

  dynamic connect(String username, String token) {
    client = StompClient(
      config: StompConfig(
        url: ApiConst.socketBase,
        onStompError: onStompError,
        onWebSocketError: onWebSocketError,
        onConnect: (event) => onConnect(username, token),
      ),
    );

    client.activate();
  }

  void onStompError(StompFrame e) {
    // print(e);
    if (!isClosed) emit(state.copyWith(exception: Exception('Some Error $e')));
  }

  void onWebSocketError(dynamic e) {
    // print(e);
    if (!isClosed) emit(state.copyWith(exception: Exception('Some Error $e')));
  }

  void callback(StompFrame event) {
    if (event.body != null) {
      final data = jsonDecode(event.body!) as List<dynamic>;
      if (!isClosed) emit(state.copyWith(pages: data));
    } else {
      if (!isClosed) emit(state.copyWith(exception: Exception('Some Error')));
    }
  }

  void onConnect(String username, String token) {
    client.subscribe(
      destination: ApiConst.userPages(username),
      headers: ApiConst.authMap(token),
      callback: callback,
    );
  }

  void sendPage(String username, String token) {
    client.send(
      destination: ApiConst.setInProgress,
      headers: ApiConst.authMap(token),
      body: jsonEncode(
        {
          'pageIds': [
            '8dac960a-e3b4-4e22-900d-746e983cb099',
            '055ca101-f258-4aaa-a8c5-e38befb0a60b',
            '56ea7c60-5265-4479-bcb8-c0d5387eb6b9'
          ],
          'username': username,
        },
      ),
    );
  }

  Future<void> setPage(int newPage) async {}

  Future<void> removePage(int newPage) async {}
}
