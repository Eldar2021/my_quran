part of 'remote_config_cubit.dart';

class RemoteConfigState extends Equatable {
  const RemoteConfigState({
    this.appVersionStatus = const NoNewVersion(),
    this.isHatimEnable = true,
    this.isDonaitonEnable = false,
    this.deviceId,
  });

  final AppVersionStatus appVersionStatus;
  final String? deviceId;
  final bool isHatimEnable;
  final bool isDonaitonEnable;

  @override
  List<Object?> get props => [appVersionStatus, deviceId, isHatimEnable, isDonaitonEnable];

  RemoteConfigState copyWith({
    AppVersionStatus? appVersionStatus,
    String? deviceId,
    bool? isHatimEnable,
    bool? isDonaitonEnable,
  }) {
    return RemoteConfigState(
      appVersionStatus: appVersionStatus ?? this.appVersionStatus,
      isHatimEnable: isHatimEnable ?? this.isHatimEnable,
      deviceId: deviceId ?? this.deviceId,
      isDonaitonEnable: isDonaitonEnable ?? this.isDonaitonEnable,
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
