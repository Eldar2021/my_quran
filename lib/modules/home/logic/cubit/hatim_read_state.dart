part of 'hatim_read_cubit.dart';

class HatimReadState extends Equatable {
  const HatimReadState(this.pages, [this.lastPage]);

  final List<int> pages;
  final int? lastPage;

  @override
  List<Object> get props => [pages];
}
