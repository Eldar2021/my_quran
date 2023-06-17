import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';

@immutable
final class NetworkClient {
  const NetworkClient(this.connectivity);

  final Connectivity connectivity;

  Future<bool> checkInternetConnection() async {
    final connectivityResult = await connectivity.checkConnectivity();
    return switch (connectivityResult) {
      ConnectivityResult.mobile || ConnectivityResult.ethernet || ConnectivityResult.wifi => true,
      _ => false,
    };
  }
}
