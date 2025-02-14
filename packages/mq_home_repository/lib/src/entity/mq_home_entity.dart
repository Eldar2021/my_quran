import 'package:flutter/material.dart';

@immutable
final class MqHomeEntity {
  const MqHomeEntity({required this.allDoneHatims, required this.allDonePages, required this.donePages});

  final int allDoneHatims;
  final int allDonePages;
  final int donePages;
}
