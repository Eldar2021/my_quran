import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mq_home_repository/mq_home_repository.dart';

part 'mq_home_banner_response.g.dart';

@JsonSerializable()
@immutable
final class MqHomeBannerResponse {
  const MqHomeBannerResponse({
    required this.imageRu,
    required this.imageEn,
    required this.imageKy,
    required this.imageTr,
    required this.hasCondition,
    this.date,
  });

  factory MqHomeBannerResponse.fromJson(Map<String, dynamic> json) => _$MqHomeBannerResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MqHomeBannerResponseToJson(this);

  final String imageRu;
  final String imageEn;
  final String imageKy;
  final String imageTr;
  final bool hasCondition;
  final String? date;

  MqHomeBannerEntity toEntity() {
    return MqHomeBannerEntity(
      imageRu: imageRu,
      imageEn: imageEn,
      imageKy: imageKy,
      imageTr: imageTr,
      hasCondition: hasCondition,
      date: date,
    );
  }
}
