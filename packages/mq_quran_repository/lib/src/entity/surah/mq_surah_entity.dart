import 'package:flutter/foundation.dart';

@immutable
final class MqSurahEntity {
  const MqSurahEntity({
    this.id,
    this.versesCount,
    this.revelationPlace,
    this.revelationOrder,
    this.bismillahPre,
    this.nameSimple,
    this.nameComplex,
    this.nameArabic,
    this.pages,
    this.translatedName,
  });

  final int? id;
  final String? revelationPlace;
  final int? revelationOrder;
  final bool? bismillahPre;
  final String? nameSimple;
  final String? nameComplex;
  final String? nameArabic;
  final int? versesCount;
  final List<int>? pages;
  final MqSurahTranslatedNameEntity? translatedName;
}

@immutable
final class MqSurahTranslatedNameEntity {
  const MqSurahTranslatedNameEntity({
    this.languageName,
    this.name,
  });

  final String? languageName;
  final String? name;
}
