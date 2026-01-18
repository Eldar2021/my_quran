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
          'codeShort': e.codeShort,
          'emoji': e.emoji,
          'officialEn': e.name.official,
          'commonEn': e.name.common,
          'nameNative': e.namesNative.first.official,
          'commonNative': e.namesNative.first.common,
          'altSpellings': e.altSpellings,
          'timezones': e.timezones,
          'idd': {
            'root': e.idd.root,
            'suffixes': e.idd.suffixes,
          },
        },
      )
      .toList();

  await createAndWriteListJsonFile(
    '$currentProjectPath/$_docsPath/docs/countries.json',
    countries,
  );
}
