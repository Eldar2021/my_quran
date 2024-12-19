import 'package:flutter/foundation.dart';
import 'package:mq_hatim_repository/mq_hatim_repository.dart';

@immutable
final class MqHatimReadEntity implements MqHatimBaseEntity {
  const MqHatimReadEntity({
    required this.id,
    required this.status,
    required this.type,
  });

  final String id;
  final String status;
  final String type;
}
