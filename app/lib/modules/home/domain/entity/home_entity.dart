import 'package:flutter/material.dart';

@immutable
final class HomeEntity {
  const HomeEntity({
    required this.allDoneHatims,
    required this.allDonePages,
    required this.donePages,
  });

  final int allDoneHatims;
  final int allDonePages;
  final int donePages;
}
