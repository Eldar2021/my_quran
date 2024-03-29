part of 'hatim_pages_cubit.dart';

class HatimPagesState extends Equatable {
  const HatimPagesState({this.pages, this.lastPage, this.exception});

  final List<HatimPages?>? pages;
  final int? lastPage;
  final Exception? exception;

  @override
  List<Object?> get props => [pages, lastPage, exception, pages?.length];

  HatimPagesState copyWith({List<HatimPages?>? pages, int? lastPage, Exception? exception}) {
    return HatimPagesState(
      pages: pages ?? this.pages,
      lastPage: lastPage ?? this.lastPage,
      exception: exception ?? this.exception,
    );
  }
}
