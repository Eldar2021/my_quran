part of 'hatim_read_cubit.dart';

class HatimReadState extends Equatable {
  const HatimReadState(this.status, this.pages, {this.lastPage, this.hatim});

  final List<int> pages;
  final int? lastPage;
  final HatimReadModel? hatim;
  final FetchStatus status;

  @override
  List<Object?> get props => [pages, hatim];

  HatimReadState copyWith({FetchStatus? status, List<int>? pages, int? lastPage, HatimReadModel? hatim}) {
    return HatimReadState(
      status ?? this.status,
      pages ?? this.pages,
      lastPage: lastPage ?? this.lastPage,
      hatim: hatim ?? this.hatim,
    );
  }
}
