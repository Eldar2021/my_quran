import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mq_storage/mq_storage.dart';
import 'package:my_quran/modules/modules.dart';

part 'quran_book_settings_state.dart';

class QuranBookSettingsCubit extends Cubit<QuranBookSettingsState> {
  QuranBookSettingsCubit(this.storage) : super(const QuranBookSettingsState());

  final PreferencesStorage storage;

  static const _readThemeKey = 'readThemeKey';

  void init() {
    final data = getInitialThemeState();
    emit(
      QuranBookSettingsState(
        modeIndex: data.modeIndex == 0 ? 0 : 1,
        verticalSpaceSize: data.verticalSpaceSize,
        horizontalSpaceSize: data.horizontalSpaceSize,
        textSize: data.textSize,
        fontType: QuranFontType.fromIndex(data.fontTypeIndex),
      ),
    );
  }

  void changeMode(int index) {
    emit(state.copyWith(modeIndex: index));
  }

  void changeTextSize(double size) {
    emit(state.copyWith(textSize: size));
  }

  void changeVerticalSpace(double space) {
    emit(state.copyWith(verticalSpaceSize: space));
  }

  void changeHorizontalSpace(double space) {
    emit(state.copyWith(horizontalSpaceSize: space));
  }

  void changeFontType(QuranFontType type) {
    emit(state.copyWith(fontType: type));
  }

  Future<void> saveChanges() async {
    final date = ReadThemeData(
      modeIndex: state.modeIndex,
      verticalSpaceSize: state.verticalSpaceSize,
      horizontalSpaceSize: state.horizontalSpaceSize,
      textSize: state.textSize,
      fontTypeIndex: state.fontType.indexValue,
    );
    await saveThemeState(date);
  }

  ReadThemeData getInitialThemeState() {
    try {
      final value = storage.readString(key: _readThemeKey);
      if (value == null) return ReadThemeData.initial;
      return ReadThemeData.fromJson(json.decode(value) as Map<String, dynamic>);
    } on Object catch (_) {
      return ReadThemeData.initial;
    }
  }

  Future<void> saveThemeState(ReadThemeData themeState) async {
    final value = json.encode(themeState.toJson());
    await storage.writeString(key: _readThemeKey, value: value);
  }
}
