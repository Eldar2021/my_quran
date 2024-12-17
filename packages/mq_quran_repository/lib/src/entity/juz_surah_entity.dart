import 'package:flutter/material.dart';

@immutable
final class JuzSurahEntity {
  const JuzSurahEntity({
    required this.name,
    required this.arName,
    required this.pages,
  });

  final String name;
  final String arName;
  final List<int> pages;
}
