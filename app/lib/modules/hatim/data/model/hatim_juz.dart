import 'package:json_annotation/json_annotation.dart';
import 'package:my_quran/modules/modules.dart';

part 'hatim_juz.g.dart';

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

  HatimJusEntity get entity {
    return HatimJusEntity(
      id: id,
      status: status,
      number: number,
      toDo: toDo,
      inProgress: inProgress,
      done: done,
    );
  }

  double get toDoPercent => (toDo * 100) / (toDo + inProgress + done);
  double get inProgressPercent => (inProgress * 100) / (toDo + inProgress + done);
  double get donePercent => (done * 100) / (toDo + inProgress + done);
}
