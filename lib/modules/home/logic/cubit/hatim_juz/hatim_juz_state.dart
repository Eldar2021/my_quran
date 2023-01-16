part of 'hatim_juz_cubit.dart';

class HatimJuzState extends Equatable {
  const HatimJuzState({this.pages});

  final List<HatimPage>? pages;

  @override
  List<Object?> get props => [pages];
}
