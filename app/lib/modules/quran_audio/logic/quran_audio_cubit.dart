import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';

import 'package:my_quran/constants/contants.dart';
import 'package:my_quran/models/models.dart';

part 'quran_audio_state.dart';

class QuranAudioCubit extends Cubit<QuranAudioState> {
  QuranAudioCubit(this.player) : super(const QuranAudioState());

  final AudioPlayer player;

  final surahs = surahData.map(Surah.fromJson).toList();

  void changeSurah(int index) => emit(state.copyWith(surah: surahs[index]));

  Future<void> nextSurah() async {
    final oldSurahIndex = (state.surah?.id ?? 1) - 1;
    if (oldSurahIndex < 113) changeSurah(oldSurahIndex + 1);
    await setUrl();
    await play();
  }

  Future<void> previousSurah() async {
    final oldSurahIndex = (state.surah?.id ?? 1) - 1;
    if (oldSurahIndex > 0) changeSurah(oldSurahIndex - 1);
    await setUrl();
    await play();
  }

  Future<void> setUrl() async {
    try {
      final duration = await player.setUrl(ApiConst.audio(state.surahPath));
      emit(state.copyWith(duration: duration));
    } catch (e) {
      emit(state.copyWith(exception: Exception(e)));
    }
  }

  Future<void> setUrlPlay(int surahIndex) async {
    await setUrl();
    await play();
  }

  Future<void> play() async => player.play();

  Future<void> pause() async => player.pause();

  Future<void> seek([double milliseconds = 500]) async {
    await player.seek(Duration(milliseconds: milliseconds.toInt()));
  }

  Future<void> stop() async => player.stop();
}
