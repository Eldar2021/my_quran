import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(const SettingsState());

  final locales = const <Locale>[
    Locale('en'),
    Locale('ky'),
    Locale('ar'),
    Locale('id'),
    Locale('tr'),
    Locale('kk'),
    Locale('ru'),
  ];

  void changeLang(int index) {
    emit(state.copyWith(currentLocale: locales[index]));
  }
}
