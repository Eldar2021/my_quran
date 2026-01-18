import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mq_auth_repository/static/countries.dart';
import 'package:collection/collection.dart';

part 'country_model.g.dart';

@JsonSerializable()
@immutable
final class WorldCountry {
  const WorldCountry({
    required this.code,
    required this.codeShort,
    required this.emoji,
    required this.officialEn,
    required this.commonEn,
    required this.nameNative,
    required this.commonNative,
    required this.altSpellings,
    required this.timezones,
    required this.idd,
  });

  factory WorldCountry.usa() {
    final firstData = countries.firstWhere((e) => e['code'] == 'USA');
    return WorldCountry.fromJson(firstData);
  }

  factory WorldCountry.fromJson(Map<String, dynamic> json) => _$WorldCountryFromJson(json);
  Map<String, dynamic> toJson() => _$WorldCountryToJson(this);

  final String code;
  final String codeShort;
  final String emoji;
  final String officialEn;
  final String commonEn;
  final String nameNative;
  final String commonNative;
  final List<String> altSpellings;
  final List<String> timezones;
  final CountryIdd idd;

  static WorldCountry? fromCode(String code) {
    final firstData = countries.firstWhereOrNull((e) => e['code'] == code);
    final data = firstData ?? countries.firstWhereOrNull((e) => e['codeShort'] == code);
    if (data != null) return WorldCountry.fromJson(data);
    return null;
  }

  static List<WorldCountry> get all {
    return countries.map(WorldCountry.fromJson).toList();
  }
}

@JsonSerializable()
@immutable
final class CountryIdd {
  const CountryIdd({
    required this.root,
    required this.suffixes,
  });

  factory CountryIdd.fromJson(Map<String, dynamic> json) => _$CountryIddFromJson(json);
  Map<String, dynamic> toJson() => _$CountryIddToJson(this);

  final int root;
  final List<int> suffixes;
}
