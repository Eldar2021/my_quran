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
    if (!isClosed) emit(state.copyWith(exception: Exception('Some Error $e')));
  }

  void onWebSocketError(dynamic e) {
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
    if (state.pages != null && state.pages!.isNotEmpty) {
      final pageIds = List.generate(state.pages!.length, (index) => state.pages![index]['id']);
      client.send(
        destination: ApiConst.setInProgress,
        headers: ApiConst.authMap(token),
        body: jsonEncode({'pageIds': pageIds, 'username': username}),
      );
    }
  }

  void donePage(String username, String token) {
    if (state.pages != null && state.pages!.isNotEmpty) {
      final pageIds = List.generate(state.pages!.length, (index) => state.pages![index]['id']);
      client.send(
        destination: ApiConst.setDone,
        headers: ApiConst.authMap(token),
        body: jsonEncode({'pageIds': pageIds, 'username': username}),
      );
    }
  }

  Future<void> setPage(int newPage) async {}

  Future<void> removePage(int newPage) async {}
}
