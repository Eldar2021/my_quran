import 'package:flutter/material.dart';

@immutable
final class MqHomeBannerEntity {
  const MqHomeBannerEntity({
    required this.imageRu,
    required this.imageEn,
    required this.imageKy,
    required this.imageTr,
    required this.hasCondition,
    this.date,
  });

  final String imageRu;
  final String imageEn;
  final String imageKy;
  final String imageTr;
  final bool hasCondition;
  final String? date;
}
