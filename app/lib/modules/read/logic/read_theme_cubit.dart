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
    switch (state.fontFamily) {
      case 'Amiri':
        return GoogleFonts.amiri();
      case 'Amiri Quran':
        return GoogleFonts.amiriQuran();
      case 'Katibeh':
        return GoogleFonts.katibeh();
      case 'Noto Sans Arabic':
        return GoogleFonts.notoSansArabic();
      case 'Scheherazade New':
        return GoogleFonts.scheherazadeNew();
      default:
        return GoogleFonts.scheherazadeNew();
    }
  }

  Future<void> saveChanges() async {
    await service.saveChanges(state);
  }
}
