part of 'hatim_juzs_cubit.dart';

class HatimJuzsState extends Equatable {
  const HatimJuzsState({this.hatimJuzs, this.erorText});

  final List<HatimJus>? hatimJuzs;
  final String? erorText;

  @override
  List<Object?> get props => [hatimJuzs, erorText, hatimJuzs?.map((e) => e)];
}
