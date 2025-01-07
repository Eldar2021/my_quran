import 'package:flutter/foundation.dart';
import 'package:mq_hatim_repository/mq_hatim_repository.dart';

@immutable
final class MqHatimJusEntity implements MqHatimBaseEntity {
  const MqHatimJusEntity({
    required this.id,
    required this.status,
    required this.number,
    required this.toDo,
    required this.inProgress,
    required this.done,
  });

  final String id;
  final String status;
  final int number;
  final int toDo;
  final int inProgress;
  final int done;

  double get toDoPercent => (toDo * 100) / (toDo + inProgress + done);
  double get inProgressPercent => (inProgress * 100) / (toDo + inProgress + done);
  double get donePercent => (done * 100) / (toDo + inProgress + done);
  int get total => toDo + inProgress + done;
}
