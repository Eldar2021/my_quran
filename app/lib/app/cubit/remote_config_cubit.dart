import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:mq_remote_config/mq_remote_config.dart';

part 'remote_config_state.dart';

class RemoteConfigCubit extends Cubit<RemoteConfigState> {
  RemoteConfigCubit(this.remoteConfig) : super(const RemoteConfigState());

  final MqRemoteConfig remoteConfig;

  Future<void> init() async {
    _emitNewState();
    remoteConfig.listen(_emitNewState);
  }

  void _emitNewState() {
    final newState = state.copyWith(
      appVersionStatus: _getAppVersionStatus,
      isHatimEnable: _hatimIsEnable,
      isDonaitonEnable: _isDonaitonEnable,
      version: remoteConfig.appVersion,
    );
    emit(newState);
  }

  bool get _hatimIsEnable => remoteConfig.hatimIsEnable;

  bool get _isDonaitonEnable => remoteConfig.donaitonIsEnable;

  AppVersionStatus get _getAppVersionStatus {
    final currentBuildNumber = int.parse(remoteConfig.buildBumber);
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
