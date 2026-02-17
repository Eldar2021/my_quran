part of 'quran_page_cubit.dart';

@immutable
sealed class QuranPageState extends Equatable {
  const QuranPageState();

  @override
  List<Object?> get props => [];
}

@immutable
final class QuranPageInitial extends QuranPageState {
  const QuranPageInitial();
}

@immutable
final class QuranPageLoading extends QuranPageState {
  const QuranPageLoading();
}

@immutable
final class QuranPageLoaded extends QuranPageState {
  const QuranPageLoaded({
    required this.data,
    this.fonts,
  });

  final QuranPageModel data;
  final QuranFontModel? fonts;

  bool get isFontLoaded => fonts != null;

  @override
  List<Object?> get props => [
    data,
    fonts,
    isFontLoaded,
  ];
}

@immutable
final class QuranPageError extends QuranPageState {
  const QuranPageError(this.error);

  final Object error;

  @override
  List<Object?> get props => [error];
}
