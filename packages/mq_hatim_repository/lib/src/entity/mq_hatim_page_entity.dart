import 'package:flutter/foundation.dart';
import 'package:mq_hatim_repository/mq_hatim_repository.dart';

@immutable
final class MqHatimPagesEntity implements MqHatimBaseEntity {
  const MqHatimPagesEntity({required this.id, required this.status, required this.number, required this.mine});

  final String id;
  final int number;
  final HatimPageStatus status;
  final bool mine;
}
