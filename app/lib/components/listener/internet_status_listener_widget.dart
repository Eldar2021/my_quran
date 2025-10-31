import 'package:flutter/material.dart';
import 'package:mq_remote_client/mq_remote_client.dart';

class InternetStatusListenerWidget extends StatefulWidget {
  const InternetStatusListenerWidget({
    this.onInternetConnected,
    this.onInternetDisconnected,
    super.key,
  });

  final void Function()? onInternetConnected;
  final void Function()? onInternetDisconnected;

  @override
  State<InternetStatusListenerWidget> createState() => _InternetStatusListenerWidgetState();
}

class _InternetStatusListenerWidgetState extends State<InternetStatusListenerWidget> {
  late final NetworkClient _networkClient;
  late final ValueNotifier<bool> _notifier;

  @override
  void initState() {
    super.initState();
    _networkClient = NetworkClient();
    _notifier = ValueNotifier<bool>(true);
    _networkClient.connectivity.onConnectivityChanged.listen((data) {
      if (data.contains(ConnectivityResult.mobile) || data.contains(ConnectivityResult.wifi)) {
        _notifier.value = true;
        widget.onInternetConnected?.call();
      } else {
        _notifier.value = false;
        widget.onInternetDisconnected?.call();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _notifier,
      builder: (context, value, child) {
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: value
              ? const Icon(
                  Icons.wifi,
                  color: Colors.green,
                )
              : const Icon(
                  Icons.wifi_off,
                  color: Colors.red,
                ),
        );
      },
    );
  }

  @override
  void dispose() {
    _notifier.dispose();
    super.dispose();
  }
}
