part of 'hatim_juz_cubit.dart';

class HatimJuzState extends Equatable {
  const HatimJuzState({this.hatimJuzs, this.erorText});

  final List<HatimJus>? hatimJuzs;
  final String? erorText;

  @override
  List<Object?> get props => [hatimJuzs, erorText];
}
