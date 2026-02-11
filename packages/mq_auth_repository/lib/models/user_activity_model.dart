import 'package:meta/meta.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_activity_model.g.dart';

@JsonSerializable()
@immutable
final class UserActivityModel {
  const UserActivityModel({
    required this.date,
    required this.openedApp,
    required this.quranReadedPagesCount,
    required this.listenedQuranSeconds,
  });

  factory UserActivityModel.fromJson(Map<String, dynamic> json) => _$UserActivityModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserActivityModelToJson(this);

  final DateTime date;
  final bool openedApp;
  final int quranReadedPagesCount;
  final double listenedQuranSeconds;
  // final bool fajrDone;
  // final bool zuhrDone;
  // final bool asrDone;
  // final bool maghribDone;
  // final bool ishaDone;

  int get score {
    var currentScore = 0;
    if (openedApp) currentScore += 1;
    if (quranReadedPagesCount > 0) currentScore += 1;
    if (listenedQuranSeconds > 0) currentScore += 1;
    return currentScore;
  }
}
