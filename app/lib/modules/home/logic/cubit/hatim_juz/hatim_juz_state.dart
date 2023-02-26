part of 'hatim_juz_cubit.dart';

class HatimJuzState extends Equatable {
  const HatimJuzState({this.pages, this.status = FetchStatus.loading});

  final List<HatimPages>? pages;
  final FetchStatus status;

  @override
  List<Object?> get props => [pages, status, pages?.length];

  HatimJuzState copyWith({List<HatimPages>? pages, FetchStatus? status}) {
    return HatimJuzState(
      pages: pages ?? this.pages,
      status: status ?? this.status,
    );
  }
}
