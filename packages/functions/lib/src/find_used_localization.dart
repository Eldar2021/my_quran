// This is only dart projext
// ignore_for_file: avoid_print

import 'dart:io';

import 'package:functions/helper/helper.dart';

const _enJsonPath = 'app/lib/l10n/arb/app_en.arb';
const _docsPath = 'packages/functions';

Future<void> main() async {
  final currentProjectPath = Directory.current.path.replaceAll('/packages/functions', '');
  final usedKeys = <String, dynamic>{};
  final unusedKeys = <String, dynamic>{};

  final enJsonData = await readJsonFile('$currentProjectPath/$_enJsonPath');
  print(enJsonData);
  final files = await readAllFilesInDirectory('$currentProjectPath/', extension: '.dart');
  print(files);

  for (final element in enJsonData.keys) {
    var isUsed = false;
    print('Start seraching for $element');
    for (final fileSystem in files) {
      print('Start seraching for $element in ${fileSystem.path}');
      final file = File(fileSystem.path);
      final fileContent = await file.readAsString();
      if (fileContent.contains('.$element') && !usedKeys.containsKey(element)) {
        usedKeys[element] = enJsonData[element];
        isUsed = true;
        break;
      }
    }
    if (!isUsed) {
      unusedKeys[element] = enJsonData[element];
    }
  }

  await createAndWriteJsonFile('$currentProjectPath/$_docsPath/docs/unused_keys.json', unusedKeys);

  await createAndWriteJsonFile('$currentProjectPath/$_docsPath/docs/used_keys.json', usedKeys);
}
