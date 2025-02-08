part of 'quran_book_by_surah_cubit.dart';

@immutable
sealed class QuranBookBySurahState {
  const QuranBookBySurahState();
}

@immutable
final class QuranBookBySurahInitial extends QuranBookBySurahState {
  const QuranBookBySurahInitial();
}

@immutable
final class QuranBookBySurahLoading extends QuranBookBySurahState {
  const QuranBookBySurahLoading();
}

@immutable
final class QuranBookBySurahLoaded extends QuranBookBySurahState {
  const QuranBookBySurahLoaded(this.dataEntity);

  final QuranDataEntity dataEntity;
}

@immutable
final class QuranBookBySurahError extends QuranBookBySurahState {
  const QuranBookBySurahError(this.error);

  final Object error;
}
