import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:mq_quran_client/mq_quran_client.dart';

part 'quran_page_model.g.dart';

@JsonSerializable()
@immutable
final class QuranPageModel extends Equatable {
  const QuranPageModel({
    required this.pageNumber,
    required this.verses,
  });

  factory QuranPageModel.fromJson(Map<String, dynamic> json) => _$QuranPageModelFromJson(json);
  Map<String, dynamic> toJson() => _$QuranPageModelToJson(this);

  final int pageNumber;
  final List<QuranVerseModel> verses;

  @override
  List<Object?> get props => [
    pageNumber,
    verses,
  ];
}
