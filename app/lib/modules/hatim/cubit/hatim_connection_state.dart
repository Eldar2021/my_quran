part of 'hatim_connection_cubit.dart';

class HatimConnectionState extends Equatable {
  const HatimConnectionState({
    this.stateType = HatimConnectionStateType.connecting,
    this.appLifecycleStateType = HatimAppLifecycleStateType.resumed,
    this.internetStateType = HatimInternetStateType.connected,
  });

  final HatimConnectionStateType stateType;
  final HatimAppLifecycleStateType appLifecycleStateType;
  final HatimInternetStateType internetStateType;

  HatimConnectionState copyWith({
    HatimConnectionStateType? stateType,
    HatimAppLifecycleStateType? appLifecycleStateType,
    HatimInternetStateType? internetStateType,
  }) {
    return HatimConnectionState(
      stateType: stateType ?? this.stateType,
      appLifecycleStateType: appLifecycleStateType ?? this.appLifecycleStateType,
      internetStateType: internetStateType ?? this.internetStateType,
    );
  }

  @override
  List<Object> get props => [
    stateType,
    appLifecycleStateType,
    internetStateType,
  ];
}

enum HatimConnectionStateType {
  connecting,
  connected,
  reconnecting,
  reconnected,
  disconnecting,
  disconnected,
}

enum HatimAppLifecycleStateType {
  resumed,
  paused,
}

enum HatimInternetStateType {
  connected,
  disconnected,
}
