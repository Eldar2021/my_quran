import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'quran_verse_model.g.dart';

@JsonSerializable()
@immutable
final class QuranVerseModel extends Equatable {
  const QuranVerseModel({
    required this.id,
    required this.verseNumber,
    required this.verseKey,
    required this.hizbNumber,
    required this.rubElHizbNumber,
    required this.rukuNumber,
    required this.manzilNumber,
    required this.textImlaei,
    required this.textUthmani,
    required this.codeV2,
    required this.chapterId,
    required this.pageNumber,
    required this.juzNumber,
    this.sajdahNumber,
  });

  factory QuranVerseModel.fromJson(Map<String, dynamic> json) => _$QuranVerseModelFromJson(json);
  Map<String, dynamic> toJson() => _$QuranVerseModelToJson(this);

  final int id;
  final int verseNumber;
  final String verseKey;
  final int hizbNumber;
  final int rubElHizbNumber;
  final int rukuNumber;
  final int manzilNumber;
  final String textImlaei;
  final String textUthmani;
  final String codeV2;
  final int chapterId;
  final int pageNumber;
  final int juzNumber;
  final int? sajdahNumber;

  @override
  List<Object?> get props => [
    id,
    verseNumber,
    verseKey,
    hizbNumber,
    rubElHizbNumber,
    rukuNumber,
    manzilNumber,
    textImlaei,
    textUthmani,
    codeV2,
    chapterId,
    pageNumber,
    juzNumber,
    sajdahNumber,
  ];
}
