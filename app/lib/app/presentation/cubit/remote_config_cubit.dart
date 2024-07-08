import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'remote_config_state.dart';

class RemoteConfigCubit extends Cubit<RemoteConfigState> {
  RemoteConfigCubit() : super(const RemoteConfigState(appVersionStatus: NoNewVersion()));

  Future<void> setAppVersionStatus({
    required int requiredBuildNumber,
    required int recommendedBuildNumber,
    required int currentBuildNumber,
  }) async {
    if (currentBuildNumber < requiredBuildNumber) {
      emit(state.copyWith(appVersionStatus: YesRequiredVersion(requiredBuildNumber)));
    } else if (currentBuildNumber < recommendedBuildNumber) {
      emit(state.copyWith(appVersionStatus: YesRecommendedVersion(recommendedBuildNumber)));
    } else {
      emit(state.copyWith(appVersionStatus: const NoNewVersion()));
    }
  }
}
