part of 'hatim_juzs_cubit.dart';

class HatimJuzsState extends Equatable {
  const HatimJuzsState({this.hatimJuzs, this.erorText, this.status = FetchStatus.loading});

  final List<HatimJus>? hatimJuzs;
  final String? erorText;
  final FetchStatus status;

  @override
  List<Object?> get props => [hatimJuzs, erorText, status, hatimJuzs?.map((e) => e)];
}
