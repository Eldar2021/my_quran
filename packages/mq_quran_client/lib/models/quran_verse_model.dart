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

  @JsonKey(name: 'id')
  final int id;

  @JsonKey(name: 'verse_number')
  final int verseNumber;

  @JsonKey(name: 'verse_key')
  final String verseKey;

  @JsonKey(name: 'hizb_number')
  final int hizbNumber;

  @JsonKey(name: 'rub_el_hizb_number')
  final int rubElHizbNumber;

  @JsonKey(name: 'ruku_number')
  final int rukuNumber;

  @JsonKey(name: 'manzil_number')
  final int manzilNumber;

  @JsonKey(name: 'text_imlaei')
  final String textImlaei;

  @JsonKey(name: 'text_uthmani')
  final String textUthmani;

  @JsonKey(name: 'code_v2')
  final String codeV2;

  @JsonKey(name: 'chapter_id')
  final int chapterId;

  @JsonKey(name: 'page_number')
  final int pageNumber;

  @JsonKey(name: 'juz_number')
  final int juzNumber;

  @JsonKey(name: 'sajdah_number')
  final int? sajdahNumber;

  int get ayatNumber => int.parse(verseKey.split(':').last);

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
