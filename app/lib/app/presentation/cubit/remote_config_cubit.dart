import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_quran/core/core.dart';
import 'package:package_info_plus/package_info_plus.dart';

part 'remote_config_state.dart';

class RemoteConfigCubit extends Cubit<RemoteConfigState> {
  RemoteConfigCubit({
    required this.packageInfo,
    required this.remoteConfig,
  }) : super(const RemoteConfigState());

  final PackageInfo packageInfo;
  final MqRemoteConfig remoteConfig;

  Future<void> init() async {
    _emitNewState();
    remoteConfig.remoteConfig.onConfigUpdated.listen((event) async {
      await remoteConfig.remoteConfig.activate();
      _emitNewState();
    });
  }

  void _emitNewState() {
    final newState = state.copyWith(
      appVersionStatus: _getAppVersionStatus,
      isHatimEnable: _hatimIsEnable,
    );
    emit(newState);
  }

  bool get _hatimIsEnable => remoteConfig.hatimIsEnable;

  AppVersionStatus get _getAppVersionStatus {
    final currentBuildNumber = int.parse(packageInfo.buildNumber);
    final requiredBuildNumber = remoteConfig.requiredBuildNumber;
    final recommendedBuildNumber = remoteConfig.recommendedBuildNumber;
    if (currentBuildNumber < requiredBuildNumber) {
      return YesRequiredVersion(requiredBuildNumber);
    } else if (currentBuildNumber < recommendedBuildNumber) {
      return YesRecommendedVersion(recommendedBuildNumber);
    } else {
      return const NoNewVersion();
    }
  }
}
