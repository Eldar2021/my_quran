part of 'read_cubit.dart';

class ReadState extends Equatable {
  const ReadState({this.fmt = QuranTextFmt.imlaei});

  final QuranTextFmt fmt;

  @override
  List<Object> get props => [fmt];

  ReadState copyWith({QuranTextFmt? fmt}) {
    return ReadState(fmt: fmt ?? this.fmt);
  }
}

enum QuranTextFmt { uthmani, imlaei }
