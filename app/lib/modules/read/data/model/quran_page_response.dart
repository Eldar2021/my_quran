import 'package:meta/meta.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:my_quran/modules/modules.dart';

part 'quran_page_response.g.dart';

@immutable
@JsonSerializable()
final class QuranPageResponse {
  const QuranPageResponse({
    required this.verses,
    required this.meta,
  });

  factory QuranPageResponse.fromJson(Map<String, dynamic> json) => _$QuranPageResponseFromJson(json);
  Map<String, dynamic> toJson() => _$QuranPageResponseToJson(this);

  final List<VerseResponse> verses;
  final MetaResponse meta;
}
