import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

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
  bool get isFirstAyat => ayatNumber == 1;
  bool get showBismillah => ayatNumber == 1 && chapterId != 1;

  String get formattedCode2 {
    if (pageNumber == 1) {
      if (ayatNumber == 1) {
        return '$codeV2\n';
      } else if (ayatNumber == 2) {
        return '$codeV2\n';
      } else if (ayatNumber == 4) {
        return '$codeV2\n';
      } else if (ayatNumber == 6) {
        final char = codeV2.characters.first;
        final char2 = codeV2.split(char).last;
        return '$char\n$char2';
      } else if (ayatNumber == 7) {
        final char = codeV2.characters.toList();
        final char1 = codeV2.split(char[6]).first;
        final char2 = codeV2.split(char[4]).last;
        final char3 = char2.split(char[14]).first;
        final char4 = char2.split(char[12]).last;
        return '$char1\n$char3\n$char4';
      }
      return codeV2;
    } else if (pageNumber == 2) {
      if (ayatNumber == 2) {
        final char1 = codeV2.split('ﱋ').first;
        final char2 = codeV2.split('ﱊ').last;
        return '$char1\n$char2';
      } else if (ayatNumber == 3) {
        final char1 = codeV2.split('ﱒ').first;
        final char2 = codeV2.split('ﱑ').last;
        return '$char1\n$char2';
      } else if (ayatNumber == 4) {
        final char1 = codeV2.split('ﱚ').first;
        final char2 = codeV2.split('ﱙ').last;
        return '$char1\n$char2';
      } else if (ayatNumber == 5) {
        final char1 = codeV2.split('ﱪ').first;
        final char2 = codeV2.split('ﱩ').last;
        return '\n$char1\n$char2';
      }
      return codeV2;
    } else {
      return codeV2;
    }
  }

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
