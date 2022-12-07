import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hatim/app/app.dart';
import 'package:hatim/theme/custom/custom_theme.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit(this.service) : super(AppState(service.init(), AppThemes.blueLight));

  final AppStorageService service;

  Future<void> changeLang(int index) async {
    final local = await service.setLocale(index);
    emit(state.copyWith(currentLocale: local, isLoading: false));
  }

  void changeTheme(AppThemes themes) => emit(AppState(service.init(), themes));
}
