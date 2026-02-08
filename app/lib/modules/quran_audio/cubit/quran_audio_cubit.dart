import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:mq_crashlytics/mq_crashlytics.dart';
import 'package:mq_quran_repository/mq_quran_repository.dart';
import 'package:mq_remote_client/mq_remote_client.dart';
import 'package:my_quran/constants/contants.dart';

part 'quran_audio_state.dart';

class QuranAudioCubit extends Cubit<QuranAudioState> {
  QuranAudioCubit(
    this.player,
    this.networkClient,
    this.quranRepository,
  ) : super(const QuranAudioState());

  final AudioPlayer player;
  final NetworkClient networkClient;
  final MqQuranRepository quranRepository;

  late final Stream<SequenceState?> sequenceStateStream;
  late final Stream<PlayerState> playerStateStream;
  late final List<MqSurahEntity> surahs;

  Future<void> init(String? userId) async {
    try {
      surahs = quranRepository.getSurahsData();
      sequenceStateStream = player.sequenceStateStream;
      playerStateStream = player.playerStateStream;
      final playList = surahs.map(
        (s) {
          final path = ApiConst.audio(s.surahPath, userId);
          log(path);
          return AudioSource.uri(
            Uri.parse(path),
            tag: MediaItem(
              id: '${s.id}',
              album: 'Quran',
              title: s.nameSimple,
              artUri: Uri.parse(ApiConst.appLogoLink),
            ),
          );
        },
      ).toList();
      await player.setAudioSources(
        playList,
        initialIndex: 0,
        preload: false,
      );
    } on Exception catch (e, s) {
      MqCrashlytics.report(e, s);
      emit(QuranAudioState(exception: e.toString()));
    }
  }

  Future<void> play() async {
    if (await networkClient.checkInternetConnection()) {
      await player.play();
    } else {
      emit(const QuranAudioState(exception: 'Internet connection'));
    }
  }

  Future<void> pause() async => player.pause();

  Future<void> stop() async => player.stop();

  Future<void> next() async => player.seekToNext();

  Future<void> previous() async => player.seekToPrevious();

  Future<void> seek([double milliseconds = 500]) async {
    await player.seek(
      Duration(milliseconds: milliseconds.toInt()),
    );
  }

  Future<void> changeSurah(int i) async {
    await player.seek(Duration.zero, index: i);
  }

  bool get hasNextSurah => player.hasNext;
  bool get hasPreviousSurah => player.hasPrevious;
}
