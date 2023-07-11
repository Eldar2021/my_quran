import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:my_quran/constants/contants.dart';

part 'quran_audio_state.dart';

class QuranAudioCubit extends Cubit<QuranAudioState> {
  QuranAudioCubit(this.player) : super(const QuranAudioState(001));

  final AudioPlayer player;

  Future<void> setUrl() async {
    final duration = await player.setUrl(ApiConst.audio(state.surahNumber));
    emit(state.copyWith(duration: duration));
  }

  Future<void> play() async {
    final duration = await player.setUrl(ApiConst.audio(state.surahNumber));
    emit(state.copyWith(duration: duration));
    await player.play();
  }

  Future<void> pause() async {
    await player.pause();
  }

  Future<void> seek([double milliseconds = 500]) async {
    await player.seek(Duration(milliseconds: milliseconds.toInt()));
  }

  Future<void> stop() async {
    await player.stop();
  }
}
