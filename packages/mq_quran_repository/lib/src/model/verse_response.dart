import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'verse_response.g.dart';

@JsonSerializable()
@immutable
final class VerseResponse {
  const VerseResponse({
    required this.id,
    required this.verseKey,
    required this.textUthmani,
  });

  factory VerseResponse.fromJson(Map<String, dynamic> json) => _$VerseResponseFromJson(json);
  Map<String, dynamic> toJson() => _$VerseResponseToJson(this);

  final int id;
  @JsonKey(name: 'verse_key')
  final String verseKey;
  @JsonKey(name: 'text_imlaei')
  final String textUthmani;
}
