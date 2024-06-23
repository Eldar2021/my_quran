import 'package:my_quran/modules/modules.dart';

class HatimReadEntity implements HatimBaseEntity {
  const HatimReadEntity({
    required this.id,
    required this.status,
    required this.type,
  });

  final String id;
  final String status;
  final String type;
}
