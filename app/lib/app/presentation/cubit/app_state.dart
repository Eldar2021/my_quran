part of 'app_cubit.dart';

class AppState extends Equatable {
  const AppState({
    required this.theme,
    required this.appVersionStatus,
    required this.appVersion,
    this.deviceId,
  });

  final CustomTheme theme;
  final String? deviceId;
  final AppVersionStatus appVersionStatus;
  final String appVersion;

  @override
  List<Object?> get props => [theme, deviceId, appVersionStatus];

  AppState copyWith({
    CustomTheme? theme,
    String? appVersion,
    String? deviceId,
    AppVersionStatus? appVersionStatus,
  }) {
    return AppState(
      theme: theme ?? this.theme,
      deviceId: deviceId ?? this.deviceId,
      appVersionStatus: appVersionStatus ?? this.appVersionStatus,
      appVersion: appVersion ?? this.appVersion,
    );
  }
}

@immutable
sealed class AppVersionStatus {
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
