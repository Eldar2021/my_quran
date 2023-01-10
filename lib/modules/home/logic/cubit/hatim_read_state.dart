part of 'hatim_read_cubit.dart';

class HatimReadState extends Equatable {
  const HatimReadState(
    this.status,
    this.pages, {
    this.lastPage,
    this.hatim,
    this.exception,
  });

  final List<int> pages;
  final int? lastPage;
  final HatimReadModel? hatim;
  final FetchStatus status;
  final Exception? exception;

  @override
  List<Object?> get props => [pages, hatim, status, exception];

  HatimReadState copyWith({
    FetchStatus? status,
    List<int>? pages,
    int? lastPage,
    HatimReadModel? hatim,
    Exception? exception,
  }) {
    return HatimReadState(
      status ?? this.status,
      pages ?? this.pages,
      lastPage: lastPage ?? this.lastPage,
      hatim: hatim ?? this.hatim,
      exception: exception ?? this.exception,
    );
  }
}
