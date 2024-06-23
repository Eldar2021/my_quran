import 'package:meta/meta.dart';
import 'package:my_quran/modules/modules.dart';

@immutable
final class HatimReadEntity implements HatimBaseEntity {
  const HatimReadEntity({
    required this.id,
    required this.status,
    required this.type,
  });

  final String id;
  final String status;
  final String type;
}
