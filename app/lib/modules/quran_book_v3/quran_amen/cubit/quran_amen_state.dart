part of 'quran_amen_cubit.dart';

@immutable
sealed class QuranAmenState extends Equatable {
  const QuranAmenState();

  @override
  List<Object> get props => [];
}

@immutable
final class QuranAmenInitial extends QuranAmenState {
  const QuranAmenInitial();
}

@immutable
final class QuranAmenLoading extends QuranAmenState {
  const QuranAmenLoading();
}

@immutable
final class QuranAmenSuccess extends QuranAmenState {
  const QuranAmenSuccess(this.isSuccess);

  final bool isSuccess;
}

@immutable
final class QuranAmenError extends QuranAmenState {
  const QuranAmenError(this.error);

  final Object error;
}
