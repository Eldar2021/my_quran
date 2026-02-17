import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'quran_surah_model.g.dart';

@JsonSerializable()
@immutable
final class QuranSurahModel extends Equatable {
  const QuranSurahModel({
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

  factory QuranSurahModel.fromJson(Map<String, dynamic> json) {
    return _$QuranSurahModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$QuranSurahModelToJson(this);
  }

  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'revelation_place')
  final String revelationPlace;
  @JsonKey(name: 'revelation_order')
  final int revelationOrder;
  @JsonKey(name: 'bismillah_pre')
  final bool bismillahPre;
  @JsonKey(name: 'name_simple')
  final String nameSimple;
  @JsonKey(name: 'name_complex')
  final String nameComplex;
  @JsonKey(name: 'name_arabic')
  final String nameArabic;
  @JsonKey(name: 'verses_count')
  final int versesCount;
  @JsonKey(name: 'pages')
  final List<int> pages;

  @override
  List<Object?> get props => [
    id,
    revelationPlace,
    revelationOrder,
    bismillahPre,
    nameSimple,
    nameComplex,
    nameArabic,
    versesCount,
    pages,
  ];
}
