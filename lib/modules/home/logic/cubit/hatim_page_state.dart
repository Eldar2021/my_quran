part of 'hatim_page_cubit.dart';

class HatimPageState extends Equatable {
  const HatimPageState({this.pages});

  final List<HatimPage>? pages;

  @override
  List<Object?> get props => [pages];
}
