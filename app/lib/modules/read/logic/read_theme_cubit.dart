import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:my_quran/modules/modules.dart';

part 'read_theme_state.dart';

class ReadThemeCubit extends Cubit<ReadThemeState> {
  ReadThemeCubit(this.service) : super(service.init());

  final ReadThemeService service;

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

  void changeFontFamily(String fontFamily) {
    emit(state.copyWith(fontFamily: fontFamily));
  }

  TextStyle getTextStyle() {
    return switch (state.fontFamily) {
      'Amiri' => GoogleFonts.amiri(),
      'Amiri Quran' => GoogleFonts.amiriQuran(),
      'Katibeh' => GoogleFonts.katibeh(),
      'Noto Sans Arabic' => GoogleFonts.notoSansArabic(),
      'Scheherazade New' => GoogleFonts.scheherazadeNew(),
      _ => GoogleFonts.scheherazadeNew(),
    };
  }

  Future<void> saveChanges() async {
    await service.saveChanges(state);
  }
}
