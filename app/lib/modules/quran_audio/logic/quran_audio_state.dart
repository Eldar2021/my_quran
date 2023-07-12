part of 'quran_audio_cubit.dart';

class QuranAudioState extends Equatable {
  const QuranAudioState({this.surah, this.duration, this.exception});

  final Surah? surah;
  final Duration? duration;
  final Exception? exception;

  @override
  List<Object?> get props => [duration, surah, exception];

  QuranAudioState copyWith({Surah? surah, Duration? duration, Exception? exception}) {
    return QuranAudioState(
      surah: surah ?? this.surah,
      duration: duration ?? this.duration,
      exception: exception ?? this.exception,
    );
  }

  String get surahPath {
    final i = surah?.id ?? 1;
    if (i < 10) return '00$i';
    if (i < 100) return '0$i';
    return '$i';
  }
}
