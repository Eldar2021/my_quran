import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';

import 'package:my_quran/config/config.dart';
import 'package:my_quran/models/models.dart';

part 'hatim_pages_state.dart';

class HatimPagesCubit extends Cubit<HatimPagesState> {
  HatimPagesCubit() : super(const HatimPagesState());

  late StompClient client;

  dynamic connect(String username, String token) {
    client = StompClient(
      config: StompConfig(
        url: apiConst.baseSocket,
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
      if (data.isNotEmpty) {
        final items = data.map((e) => HatimPages.fromJson(e as Map<String, dynamic>)).toList();
        if (!isClosed) emit(state.copyWith(pages: items));
      } else {
        if (!isClosed) emit(state.copyWith(pages: <HatimPages>[]));
      }
    } else {
      if (!isClosed) emit(state.copyWith(exception: Exception('Some Error')));
    }
  }

  void onConnect(String username, String token) {
    client.subscribe(
      destination: apiConst.userPages(username),
      headers: apiConst.authMap(token),
      callback: callback,
    );
  }

  void sendPage(String username, String token) {
    if (state.pages != null && state.pages!.isNotEmpty) {
      final pageIds = List.generate(state.pages!.length, (index) => state.pages![index]!.id);
      client.send(
        destination: apiConst.setInProgress,
        headers: apiConst.authMap(token),
        body: jsonEncode({'pageIds': pageIds, 'username': username}),
      );
    }
  }

  void donePage(String username, String token) {
    if (state.pages != null && state.pages!.isNotEmpty) {
      final pageIds = List.generate(state.pages!.length, (index) => state.pages![index]!.id);
      client.send(
        destination: apiConst.setDone,
        headers: apiConst.authMap(token),
        body: jsonEncode({'pageIds': pageIds, 'username': username}),
      );
    }
  }

  @override
  Future<void> close() {
    client.deactivate();
    return super.close();
  }

  Future<void> setPage(int newPage) async {}

  Future<void> removePage(int newPage) async {}
}
