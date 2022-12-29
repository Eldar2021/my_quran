import 'package:json_annotation/json_annotation.dart';

part 'verse.g.dart';

@JsonSerializable()
class Verse {
  const Verse({required this.id, required this.verseKey, required this.textUthmani});

  factory Verse.fromJson(Map<String, dynamic> json) => _$VerseFromJson(json);
  Map<String, dynamic> toJson() => _$VerseToJson(this);

  final int id;
  @JsonKey(name: 'verse_key')
  final String verseKey;
  @JsonKey(name: 'text_uthmani')
  final String textUthmani;

  int get juzNumber => int.parse(verseKey.split(':').first);
  int get ayatNumber => int.parse(verseKey.split(':').last);
}
