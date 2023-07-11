part of 'quran_audio_cubit.dart';

class QuranAudioState extends Equatable {
  const QuranAudioState(this.surahIndex, {this.duration});

  final int surahIndex;
  final Duration? duration;
  

  @override
  List<Object?> get props => [surahIndex, duration];

  QuranAudioState copyWith({int? surahIndex, Duration? duration}) {
    return QuranAudioState(
      surahIndex ?? this.surahIndex,
      duration: duration ?? this.duration,
    );
  }

  String get surahNumber => surahIndex < 10 ? '00$surahIndex' : '$surahIndex';
}
