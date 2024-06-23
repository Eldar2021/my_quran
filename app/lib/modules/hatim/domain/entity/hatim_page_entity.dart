import 'package:my_quran/modules/modules.dart';

class HatimPagesEntity {
  const HatimPagesEntity({
    required this.id,
    required this.status,
    required this.number,
    required this.mine,
  });

  final String id;
  final int number;
  final HatimPageStatus status;
  final bool mine;
}
