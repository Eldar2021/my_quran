import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mq_quran_repository/mq_quran_repository.dart';

part 'quran_data_verse_response.g.dart';

sealed class QuranDataVerseResponse {
  const QuranDataVerseResponse({
    required this.id,
    required this.verseKey,
    required this.text,
  });

  factory QuranDataVerseResponse.fromJson(Map<String, dynamic> json) {
    if (json.containsKey('text_uthmani_simple')) {
      return QuranDataVerseUthmaniSimpleResponse.fromJson(json);
    } else if (json.containsKey('text_imlaei')) {
      return QuranDataVerseImlaeiResponse.fromJson(json);
    } else {
      throw Exception('Unknown QuranDataFilterResponse');
    }
  }

  Map<String, dynamic> toJson();

  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'verse_key')
  final String verseKey;
  final String text;

  QuranDataVerseEntity toEntity() {
    return switch (this) {
      QuranDataVerseUthmaniSimpleResponse() => QuranDataVerseUthmaniSimpleEntity(
          id: id,
          verseKey: verseKey,
          textUtmaniSimple: text,
        ),
      QuranDataVerseImlaeiResponse() => QuranDataVerseImlaeiEntity(
          id: id,
          verseKey: verseKey,
          textImlaei: text,
        ),
    };
  }
}

@JsonSerializable()
@immutable
final class QuranDataVerseUthmaniSimpleResponse extends QuranDataVerseResponse {
  const QuranDataVerseUthmaniSimpleResponse({
    required super.id,
    required super.verseKey,
    required this.textUtmaniSimple,
  }) : super(text: textUtmaniSimple);

  factory QuranDataVerseUthmaniSimpleResponse.fromJson(Map<String, dynamic> json) =>
      _$QuranDataVerseUthmaniSimpleResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$QuranDataVerseUthmaniSimpleResponseToJson(this);

  @JsonKey(name: 'text_uthmani_simple')
  final String textUtmaniSimple;
}

@JsonSerializable()
@immutable
final class QuranDataVerseImlaeiResponse extends QuranDataVerseResponse {
  const QuranDataVerseImlaeiResponse({
    required super.id,
    required super.verseKey,
    required this.textImlaei,
  }) : super(text: textImlaei);

  factory QuranDataVerseImlaeiResponse.fromJson(Map<String, dynamic> json) =>
      _$QuranDataVerseImlaeiResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$QuranDataVerseImlaeiResponseToJson(this);

  @JsonKey(name: 'text_imlaei')
  final String textImlaei;
}
