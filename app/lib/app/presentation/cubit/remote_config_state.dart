part of 'remote_config_cubit.dart';

class RemoteConfigState extends Equatable {
  const RemoteConfigState({
    required this.appVersionStatus,
    this.deviceId,
  });

  final AppVersionStatus appVersionStatus;
  final String? deviceId;

  @override
  List<Object?> get props => [appVersionStatus, deviceId];

  RemoteConfigState copyWith({
    AppVersionStatus? appVersionStatus,
    String? deviceId,
    bool? disableHatim,
  }) {
    return RemoteConfigState(
      appVersionStatus: appVersionStatus ?? this.appVersionStatus,
      deviceId: deviceId ?? this.deviceId,
    );
  }
}

@immutable
abstract class AppVersionStatus {
  const AppVersionStatus();
}

@immutable
final class NoNewVersion extends AppVersionStatus {
  const NoNewVersion();
}

@immutable
final class YesRecommendedVersion extends AppVersionStatus {
  const YesRecommendedVersion(this.buildNumber);

  final int buildNumber;
}

@immutable
final class YesRequiredVersion extends AppVersionStatus {
  const YesRequiredVersion(this.buildNumber);

  final int buildNumber;
}
