import 'package:flutter/material.dart';

@immutable
final class MqStoryEntity {
  const MqStoryEntity({
    required this.cardImageUrl,
    required this.cardLabel,
    required this.isViewed,
    required this.button,
    required this.screens,
  });

  final String cardImageUrl;
  final String cardLabel;
  final bool isViewed;
  final MqStoryButtonEntity button;
  final List<MqStoryScreenEntity> screens;
}

@immutable
final class MqStoryButtonEntity {
  const MqStoryButtonEntity({required this.hasButton, required this.label, required this.action});

  final bool hasButton;
  final String label;
  final String action;
}

@immutable
final class MqStoryScreenEntity {
  const MqStoryScreenEntity({required this.imageUrl, required this.durationByMilliseconds});

  final String imageUrl;
  final int durationByMilliseconds;
}
