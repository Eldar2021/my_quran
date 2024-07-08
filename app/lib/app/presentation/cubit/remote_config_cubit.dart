import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_quran/core/core.dart';
import 'package:package_info_plus/package_info_plus.dart';

part 'remote_config_state.dart';

class RemoteConfigCubit extends Cubit<RemoteConfigState> {
  RemoteConfigCubit(this.packageInfo, this.remoteConfig)
      : super(const RemoteConfigState(appVersionStatus: NoNewVersion(), isHatimEnable: true));

  final PackageInfo packageInfo;
  final MqRemoteConfig remoteConfig;

  Future<void> init() async {
    await setAppVersionStatus(
      requiredBuildNumber: remoteConfig.requiredBuildNumber,
      recommendedBuildNumber: remoteConfig.recommendedBuildNumber,
    );

    emit(state.copyWith(isHatimEnable: remoteConfig.hatimIsEnable));

    remoteConfig.remoteConfig.onConfigUpdated.listen((event) async {
      await remoteConfig.remoteConfig.activate();
    });
  }

  Future<void> setAppVersionStatus({
    required int requiredBuildNumber,
    required int recommendedBuildNumber,
  }) async {
    final currentBuildNumber = int.parse(packageInfo.buildNumber);

    if (currentBuildNumber < requiredBuildNumber) {
      emit(state.copyWith(appVersionStatus: YesRequiredVersion(requiredBuildNumber)));
    } else if (currentBuildNumber < recommendedBuildNumber) {
      emit(state.copyWith(appVersionStatus: YesRecommendedVersion(recommendedBuildNumber)));
    } else {
      emit(state.copyWith(appVersionStatus: const NoNewVersion()));
    }
  }
}
