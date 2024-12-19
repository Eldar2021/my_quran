import 'package:json_annotation/json_annotation.dart';
import 'package:mq_hatim_repository/mq_hatim_repository.dart';

part 'mq_hatim_juz.g.dart';

@JsonSerializable()
class HatimJus {
  const HatimJus({
    required this.id,
    required this.status,
    required this.number,
    required this.toDo,
    required this.inProgress,
    required this.done,
  });

  factory HatimJus.fromJson(Map<String, dynamic> json) => _$HatimJusFromJson(json);
  Map<String, dynamic> toJson() => _$HatimJusToJson(this);

  final String id;
  final String status;
  final int number;
  final int toDo;
  final int inProgress;
  final int done;

  MqHatimJusEntity get entity {
    return MqHatimJusEntity(
      id: id,
      status: status,
      number: number,
      toDo: toDo,
      inProgress: inProgress,
      done: done,
    );
  }
}
