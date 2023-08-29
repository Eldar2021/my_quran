part of 'quran_audio_cubit.dart';

class QuranAudioState extends Equatable {
  const QuranAudioState({this.exception});

  final String? exception;

  @override
  List<Object?> get props => [exception];

  QuranAudioState copyWith({String? exception}) {
    return QuranAudioState(exception: exception ?? this.exception);
  }
}
