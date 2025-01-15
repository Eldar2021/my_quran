import 'package:flutter/material.dart';
import 'package:mq_prayer_time/mq_prayer_time.dart';

@immutable
final class MqLocationClient {
  const MqLocationClient({
    required this.locationService,
    required this.locationStorage,
  });

  final MqLocationService locationService;
  final MqLocationStorage locationStorage;
}
