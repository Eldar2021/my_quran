import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mq_home_repository/mq_home_repository.dart';

part 'mq_story_model_response.g.dart';

@JsonSerializable()
@immutable
final class MqStoryModelResponse {
  const MqStoryModelResponse({
    required this.cardImageUrl,
    required this.cardLabel,
    required this.isViewed,
    required this.button,
    required this.screens,
  });

  factory MqStoryModelResponse.fromJson(Map<String, dynamic> json) => _$MqStoryModelResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MqStoryModelResponseToJson(this);

  final String cardImageUrl;
  final String cardLabel;
  final bool isViewed;
  final MqStoryButtonResponse button;
  final List<MqStoryScreenResponse> screens;

  MqStoryEntity toEntity() {
    return MqStoryEntity(
      cardImageUrl: cardImageUrl,
      cardLabel: cardLabel,
      isViewed: isViewed,
      button: button.toEntity(),
      screens: screens.map((e) => e.toEntity()).toList(),
    );
  }
}

@JsonSerializable()
@immutable
final class MqStoryButtonResponse {
  const MqStoryButtonResponse({
    required this.hasButton,
    required this.label,
    required this.action,
  });

  factory MqStoryButtonResponse.fromJson(Map<String, dynamic> json) => _$MqStoryButtonResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MqStoryButtonResponseToJson(this);

  final bool hasButton;
  final String label;
  final String action;

  MqStoryButtonEntity toEntity() {
    return MqStoryButtonEntity(
      hasButton: hasButton,
      label: label,
      action: action,
    );
  }
}

@JsonSerializable()
@immutable
final class MqStoryScreenResponse {
  const MqStoryScreenResponse({
    required this.imageUrl,
    required this.durationByMilliseconds,
  });

  factory MqStoryScreenResponse.fromJson(Map<String, dynamic> json) => _$MqStoryScreenResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MqStoryScreenResponseToJson(this);

  final String imageUrl;
  final int durationByMilliseconds;

  MqStoryScreenEntity toEntity() {
    return MqStoryScreenEntity(
      imageUrl: imageUrl,
      durationByMilliseconds: durationByMilliseconds,
    );
  }
}
