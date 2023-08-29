import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';

import 'package:my_quran/constants/contants.dart';
import 'package:my_quran/models/models.dart';

part 'quran_audio_state.dart';

class QuranAudioCubit extends Cubit<QuranAudioState> {
  QuranAudioCubit(this.player) : super(const QuranAudioState());

  final AudioPlayer player;
  late final Stream<SequenceState?> sequenceStateStream;
  late final Stream<PlayerState> playerStateStream;
  late final List<Surah> surahs;

  Future<void> init() async {
    try {
      surahs = surahData.map(Surah.fromJson).toList();
      sequenceStateStream = player.sequenceStateStream;
      playerStateStream = player.playerStateStream;
      final playList = ConcatenatingAudioSource(
        shuffleOrder: DefaultShuffleOrder(),
        children: surahs
            .map(
              (s) => AudioSource.uri(
                Uri.parse(ApiConst.audio(s.surahPath)),
                tag: MediaItem(id: '${s.id}', album: 'Quran', title: s.name),
              ),
            )
            .toList(),
      );
      await player.setAudioSource(playList, initialIndex: 0, preload: false);
    } catch (e) {
      emit(state.copyWith(exception: e.toString()));
    }
  }

  Future<void> play() async => player.play();
  Future<void> pause() async => player.pause();
  Future<void> stop() async => player.stop();
  Future<void> next() async => player.seekToNext();
  Future<void> previous() async => player.seekToPrevious();

  Future<void> seek([double milliseconds = 500]) async {
    await player.seek(Duration(milliseconds: milliseconds.toInt()));
  }

  Future<void> changeSurah(int i) async {
    await player.seek(Duration.zero, index: i);
  }

  bool get hasNextSurah => player.hasNext;
  bool get hasPreviousSurah => player.hasPrevious;
}
