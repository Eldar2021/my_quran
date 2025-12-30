part of 'remote_config_cubit.dart';

class RemoteConfigState extends Equatable {
  const RemoteConfigState({
    this.appVersionStatus = const NoNewVersion(),
    this.isHatimEnable = true,
    this.isDonaitonEnable = false,
    this.version,
    this.deviceId,
    this.buildNumber,
  });

  final AppVersionStatus appVersionStatus;
  final String? deviceId;
  final bool isHatimEnable;
  final bool isDonaitonEnable;
  final String? version;
  final String? buildNumber;

  @override
  List<Object?> get props => [
    appVersionStatus,
    deviceId,
    isHatimEnable,
    isDonaitonEnable,
    version,
    buildNumber,
  ];

  RemoteConfigState copyWith({
    AppVersionStatus? appVersionStatus,
    String? deviceId,
    bool? isHatimEnable,
    bool? isDonaitonEnable,
    String? version,
    String? buildNumber,
  }) {
    return RemoteConfigState(
      appVersionStatus: appVersionStatus ?? this.appVersionStatus,
      isHatimEnable: isHatimEnable ?? this.isHatimEnable,
      deviceId: deviceId ?? this.deviceId,
      isDonaitonEnable: isDonaitonEnable ?? this.isDonaitonEnable,
      version: version ?? this.version,
      buildNumber: buildNumber ?? this.buildNumber,
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
