import 'package:flutter/material.dart';

@immutable
final class SurahEntity {
  const SurahEntity({
    required this.id,
    required this.name,
    required this.aya,
    required this.pages,
    required this.arabic,
  });

  final int id;
  final String name;
  final int aya;
  final List<int> pages;
  final String arabic;

  String get surahPath {
    if (id < 10) return '00$id';
    if (id < 100) return '0$id';
    return '$id';
  }
}
