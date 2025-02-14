import 'package:flutter/foundation.dart';

@immutable
final class MqSurahEntity {
  const MqSurahEntity({
    required this.id,
    required this.versesCount,
    required this.revelationPlace,
    required this.revelationOrder,
    required this.bismillahPre,
    required this.nameSimple,
    required this.nameComplex,
    required this.nameArabic,
    required this.pages,
  });

  final int id;
  final String revelationPlace;
  final int revelationOrder;
  final bool bismillahPre;
  final String nameSimple;
  final String nameComplex;
  final String nameArabic;
  final int versesCount;
  final List<int> pages;

  String get surahPath {
    if (id < 10) return '00$id';
    if (id < 100) return '0$id';
    return '$id';
  }
}

@immutable
final class MqSurahTranslatedNameEntity {
  const MqSurahTranslatedNameEntity({required this.languageName, required this.name});

  final String languageName;
  final String name;
}
