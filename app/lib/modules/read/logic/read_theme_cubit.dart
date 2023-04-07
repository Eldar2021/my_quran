import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_quran/modules/modules.dart';

part 'read_theme_state.dart';

class ReadThemeCubit extends Cubit<ReadThemeState> {
  ReadThemeCubit(this.service) : super(ReadThemeState(service.init()));

  final ReadThemeService service;

  void changeMode(int index) {
    emit(ReadThemeState(state.theme.copyWith(modeIndex: index)));
  }

  void changeTextSize(int size) {
    emit(ReadThemeState(state.theme.copyWith(textSize: size)));
  }

  void changeVerticalSpace(int space) {
    emit(ReadThemeState(state.theme.copyWith(verticalSpaceSize: space)));
  }

  void changeHorizontalSpace(int space) {
    emit(ReadThemeState(state.theme.copyWith(horizontalSpaceSize: space)));
  }

  void changeFontFamily(String fontFamily) {
    emit(ReadThemeState(state.theme.copyWith(fontFamily: fontFamily)));
  }

  TextStyle getTextStyle({double? fontSize, Color? color, double? height}) {
    switch (state.theme.fontFamily) {
      case 'Amiri':
        return GoogleFonts.amiri(fontSize: fontSize, color: color, height: height);
      case 'Amiri Quran':
        return GoogleFonts.amiriQuran(fontSize: fontSize, color: color, height: height);
      case 'Katibeh':
        return GoogleFonts.katibeh(fontSize: fontSize, color: color, height: height);
      case 'Noto Sans Arabic':
        return GoogleFonts.notoSansArabic(fontSize: fontSize, color: color, height: height);
      case 'Scheherazade New':
        return GoogleFonts.scheherazadeNew(fontSize: fontSize, color: color, height: height);
      default:
        return GoogleFonts.scheherazadeNew(fontSize: fontSize, color: color, height: height);
    }
  }

  Future<void> saveChanges() async {
    await service.saveChanges(state.theme);
  }
}
