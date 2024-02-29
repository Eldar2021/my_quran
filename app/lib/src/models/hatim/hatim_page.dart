import 'dart:ui';

import 'package:json_annotation/json_annotation.dart';
import 'package:my_quran/src/src.dart';

part 'hatim_page.g.dart';

@JsonSerializable()
class HatimPages {
  const HatimPages({
    required this.id,
    required this.status,
    required this.number,
    required this.mine,
  });

  factory HatimPages.fromJson(Map<String, dynamic> json) => _$HatimPagesFromJson(json);
  Map<String, dynamic> toJson() => _$HatimPagesToJson(this);

  final String id;
  final int number;
  final HatimPageStatus status;
  final bool mine;
}

enum HatimPageStatus {
  @JsonValue('TODO')
  todo,
  @JsonValue('BOOKED')
  booked,
  @JsonValue('IN_PROGRESS')
  inProgress,
  @JsonValue('DONE')
  done;

  Color get bgColor {
    return switch (this) {
      HatimPageStatus.done => AppColors.red,
      HatimPageStatus.booked || HatimPageStatus.inProgress => AppColors.yellow,
      _ => AppColors.green,
    };
  }

  Color get frColor {
    return switch (this) {
      HatimPageStatus.done || HatimPageStatus.todo => AppColors.white,
      _ => AppColors.black,
    };
  }

  Color? get iconColor {
    return switch (this) {
      HatimPageStatus.done => null,
      _ => AppColors.black,
    };
  }

  bool get isActive {
    return switch (this) {
      HatimPageStatus.todo || HatimPageStatus.booked => true,
      _ => false,
    };
  }
}
