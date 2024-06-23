import 'package:my_quran/modules/modules.dart';

class HatimJusEntity implements HatimBaseEntity {
  const HatimJusEntity({
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
}
