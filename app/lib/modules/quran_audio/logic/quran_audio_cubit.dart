import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:my_quran/config/config.dart';
import 'package:my_quran/core/core.dart';
import 'package:my_quran/models/models.dart';

part 'quran_audio_state.dart';

class QuranAudioCubit extends Cubit<QuranAudioState> {
  QuranAudioCubit(this.player, this.networkClient) : super(QuranAudioState());

  final AudioPlayer player;
  final NetworkClient networkClient;
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
                Uri.parse(apiConst.audio(s.surahPath)),
                tag: MediaItem(
                  id: '${s.id}',
                  album: 'Quran',
                  title: s.name,
                  artUri: Uri.parse(apiConst.appLogoLink),
                ),
              ),
            )
            .toList(),
      );
      await player.setAudioSource(playList, initialIndex: 0, preload: false);
    } catch (e) {
      emit(QuranAudioState(exception: e.toString()));
    }
  }

  Future<void> play() async {
    if (await networkClient.checkInternetConnection()) {
      await player.play();
    } else {
      emit(QuranAudioState(exception: 'Internet connection'));
    }
  }

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
