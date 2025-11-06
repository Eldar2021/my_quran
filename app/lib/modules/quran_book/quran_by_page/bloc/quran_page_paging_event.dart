part of 'quran_page_paging_bloc.dart';

sealed class QuranPagePagingEvent extends Equatable {
  const QuranPagePagingEvent();

  @override
  List<Object> get props => [];
}

@immutable
final class QuranPagePagingFetchNex extends QuranPagePagingEvent {
  const QuranPagePagingFetchNex({
    required this.pageNumber,
    required this.quranFmt,
  });

  final int pageNumber;
  final String quranFmt;
}

@immutable
final class QuranPagePagingRefresh extends QuranPagePagingEvent {
  const QuranPagePagingRefresh({
    required this.pageNumber,
    required this.quranFmt,
  });

  final int pageNumber;
  final String quranFmt;
}

@immutable
final class QuranPagePagingCancel extends QuranPagePagingEvent {
  const QuranPagePagingCancel();
}
