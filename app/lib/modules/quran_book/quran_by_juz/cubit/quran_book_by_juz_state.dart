part of 'quran_book_by_juz_cubit.dart';

@immutable
sealed class QuranBookByJuzState {
  const QuranBookByJuzState();
}

@immutable
final class QuranBookByJuzInitial extends QuranBookByJuzState {
  const QuranBookByJuzInitial();
}

@immutable
final class QuranBookByJuzLoading extends QuranBookByJuzState {
  const QuranBookByJuzLoading();
}

@immutable
final class QuranBookByJuzLoaded extends QuranBookByJuzState {
  const QuranBookByJuzLoaded(this.data);

  final QuranDataEntity data;
}

@immutable
final class QuranBookByJuzError extends QuranBookByJuzState {
  const QuranBookByJuzError(this.error);

  final Object error;
}
