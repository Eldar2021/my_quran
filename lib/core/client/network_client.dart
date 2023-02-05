import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkClient {
  const NetworkClient(this.connectivity);

  final Connectivity connectivity;

  Future<bool> checkInternetConnection() async {
    final connectivityResult = await connectivity.checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      return false;
    } else {
      return true;
    }
  }
}
