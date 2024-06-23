import 'package:meta/meta.dart';
import 'package:my_quran/modules/modules.dart';

@immutable
final class HatimPagesEntity implements HatimBaseEntity {
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
