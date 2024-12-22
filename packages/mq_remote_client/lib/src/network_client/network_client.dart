import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:meta/meta.dart';

/// A client for checking the device's internet connection status.
@immutable
class NetworkClient {
  /// Creates a [NetworkClient] with the given [connectivity] instance.
  NetworkClient({Connectivity? connectivity}) : connectivity = connectivity ?? Connectivity();

  /// The [Connectivity] instance used to check the connection type.
  final Connectivity connectivity;

  /// Checks if the device is connected to the internet via mobile, ethernet, or Wi-Fi.
  /// Returns `true` if connected, `false` otherwise.
  Future<bool> checkInternetConnection() async {
    final connectivityResult = await connectivity.checkConnectivity();
    return connectivityResult.any(
      (element) =>
          element == ConnectivityResult.mobile ||
          element == ConnectivityResult.ethernet ||
          element == ConnectivityResult.wifi,
    );
  }
}
