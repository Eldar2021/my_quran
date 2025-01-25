part of 'quran_read_cubit.dart';

@immutable
final class ReadState extends Equatable {
  const ReadState({this.fmt = QuranTextFmt.uthmani});

  final QuranTextFmt fmt;

  @override
  List<Object> get props => [fmt];

  ReadState copyWith({QuranTextFmt? fmt}) {
    return ReadState(fmt: fmt ?? this.fmt);
  }
}

enum QuranTextFmt { uthmani, imlaei }
