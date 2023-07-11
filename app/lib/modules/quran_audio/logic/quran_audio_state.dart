part of 'quran_audio_cubit.dart';

class QuranAudioState extends Equatable {
  const QuranAudioState({this.surah, this.duration});

  final Surah? surah;
  final Duration? duration;

  @override
  List<Object?> get props => [duration, surah];

  QuranAudioState copyWith({Surah? surah, Duration? duration}) {
    return QuranAudioState(
      surah: surah ?? this.surah,
      duration: duration ?? this.duration,
    );
  }

  String get surahPath {
    final i = surah?.id ?? 1;
    if (i < 10) return '00$i';
    if (i < 100) return '0$i';
    return '$i';
  }
}
