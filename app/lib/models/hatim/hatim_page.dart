import 'package:json_annotation/json_annotation.dart';

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
  final Status status;
  final bool mine;
}

enum Status {
  @JsonValue('TODO')
  todo,
  @JsonValue('BOOKED')
  booked,
  @JsonValue('IN_PROGRESS')
  inProgress,
  @JsonValue('DONE')
  done,
}
