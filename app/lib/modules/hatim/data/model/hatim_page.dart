import 'dart:ui';

import 'package:json_annotation/json_annotation.dart';
import 'package:my_quran/modules/modules.dart';

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

  HatimPagesEntity get entity {
    return HatimPagesEntity(
      id: id,
      status: status,
      number: number,
      mine: mine,
    );
  }
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
      HatimPageStatus.done => const Color(0xffA851FA).withOpacity(0.6),
      HatimPageStatus.booked || HatimPageStatus.inProgress => const Color(0xffC992B1).withOpacity(0.6),
      _ => const Color(0xffF6684E).withOpacity(0.9),
    };
  }

  Color get frColor {
    return switch (this) {
      HatimPageStatus.done => const Color(0xffA851FA).withOpacity(0.6),
      HatimPageStatus.booked || HatimPageStatus.inProgress => const Color(0xffC992B1).withOpacity(0.6),
      _ => const Color(0xffF6684E).withOpacity(0.9),
    };
  }

  Color? get iconColor {
    return switch (this) {
      HatimPageStatus.done => const Color(0xffA851FA).withOpacity(0.6),
      HatimPageStatus.booked || HatimPageStatus.inProgress => const Color(0xffC992B1).withOpacity(0.6),
      _ => const Color(0xffF6684E).withOpacity(0.9),
    };
  }

  bool get isActive {
    return switch (this) {
      HatimPageStatus.todo || HatimPageStatus.booked => true,
      _ => false,
    };
  }
}
