part of 'quran_audio_cubit.dart';

class QuranAudioState extends Equatable {
  const QuranAudioState(this.surahIndex);

  final int surahIndex;

  @override
  List<Object?> get props => [surahIndex];

  QuranAudioState copyWith({int? surahIndex}) {
    return QuranAudioState(
      surahIndex ?? this.surahIndex,
    );
  }
}
