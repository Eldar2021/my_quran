import 'dart:io';

import 'package:functions/helper/helper.dart';
import 'package:sealed_countries/sealed_countries.dart';

const _docsPath = 'packages/functions';

void main(List<String> args) async {
  final currentProjectPath = Directory.current.path.replaceAll(
    '/packages/functions',
    '',
  );

  final List<Map<String, dynamic>> countries = WorldCountry.list
      .map(
        (e) => {
          'code': e.code,
          'codeNumeric': e.codeNumeric,
          'codeShort': e.codeShort,
          'cioc': e.cioc,
          'emoji': e.emoji,
          'continent': e.continent.name,
          'subregion': e.subregion?.name,
          'lat': e.latLng.latitude,
          'long': e.latLng.longitude,
          'areaMetric': e.areaMetric,
          'name': {
            'officialEn': e.name.official,
            'commonEn': e.name.common,
            'nameNative': e.namesNative.first.official,
            'commonNative': e.namesNative.first.common,
            'altSpellings': e.altSpellings,
          },
          'languages': e.languages
              .map(
                (l) => {
                  'name': l.name,
                  'code': l.code,
                  'codeShort': l.codeShort,
                  'namesNative': l.namesNative,
                },
              )
              .toList(),
          'tld': e.tld,
          'idd': {
            'root': e.idd.root,
            'suffixes': e.idd.suffixes,
          },
          'maps': {
            'googleMaps': e.maps.googleMaps,
            'openStreetMaps': e.maps.openStreetMaps,
          },
          'population': e.population,
          'fifa': e.fifa,
          'timezones': e.timezones,
          'postalCode': {
            'format': e.postalCode?.format,
            'regex': e.postalCode?.regExpPattern,
          },
          'currency': e.currencies
              ?.map(
                (c) => {
                  'code': c.code,
                  'name': c.name,
                  'symbol': c.symbol,
                  'alternateSymbols': c.alternateSymbols,
                  'namesNative': c.namesNative,
                  'subunit': c.subunit,
                },
              )
              .toList(),
        },
      )
      .toList();

  await createAndWriteListJsonFile(
    '$currentProjectPath/$_docsPath/docs/countries.json',
    countries,
  );
}
