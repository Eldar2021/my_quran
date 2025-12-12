import 'dart:async';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

mixin InternetConnectionMixin<T extends StatefulWidget> on State<T> {
  StreamSubscription<InternetStatus>? _internetSubscription;

  void Function()? onConnectedInternet;
  void Function()? onDisconnectedInternet;

  void initConnection() {
    _initInternetListener();
  }

  void disposeConnection() {
    _internetSubscription?.cancel();
  }

  void _initInternetListener() {
    _internetSubscription = InternetConnection().onStatusChange.listen((InternetStatus status) {
      if (status == InternetStatus.connected) {
        onConnectedInternet?.call();
      } else {
        onDisconnectedInternet?.call();
      }
    });
  }
}
