import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'continent_model_response.g.dart';

@JsonSerializable()
@immutable
class ContinentModelResponse {
  const ContinentModelResponse({required this.list});

  factory ContinentModelResponse.fromJson(Map<String, dynamic> json) => _$ContinentModelResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ContinentModelResponseToJson(this);

  final List<Continent> list;
}

@JsonSerializable()
@immutable
class Continent {
  const Continent({
    required this.id,
    this.title,
    this.titleRu,
    this.titleEn,
    this.parentId,
    this.createdAt,
    this.updatedAt,
  });

  factory Continent.fromJson(Map<String, dynamic> json) => _$ContinentFromJson(json);
  Map<String, dynamic> toJson() => _$ContinentToJson(this);

  final int id;
  final String? title;
  final String? titleRu;
  final String? titleEn;
  final int? parentId;
  final String? createdAt;
  final String? updatedAt;
}
