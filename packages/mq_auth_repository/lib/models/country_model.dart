import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

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
