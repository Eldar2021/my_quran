part of 'quran_book_by_page_cubit.dart';

@immutable
sealed class QuranBookByPageState {
  const QuranBookByPageState();
}

@immutable
final class QuranBookByPageInitial extends QuranBookByPageState {
  const QuranBookByPageInitial();
}

@immutable
final class QuranBookByPageLoading extends QuranBookByPageState {
  const QuranBookByPageLoading();
}

@immutable
final class QuranBookByPageLoaded extends QuranBookByPageState {
  const QuranBookByPageLoaded(this.data);

  final QuranDataEntity data;
}

@immutable
final class QuranBookByPageError extends QuranBookByPageState {
  const QuranBookByPageError(this.error);

  final Object error;
}
