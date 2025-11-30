// This is only dart projext
// ignore_for_file: avoid_print

import 'dart:io';

import 'package:functions/helper/helper.dart';

const _enJsonPath = 'app/lib/l10n/arb/app_en.arb';
const _arJsonPath = 'app/lib/l10n/arb/app_ar.arb';
const _idJsonPath = 'app/lib/l10n/arb/app_id.arb';
const _kkJsonPath = 'app/lib/l10n/arb/app_kk.arb';
const _kyJsonPath = 'app/lib/l10n/arb/app_ky.arb';
const _ruJsonPath = 'app/lib/l10n/arb/app_ru.arb';
const _trJsonPath = 'app/lib/l10n/arb/app_tr.arb';

const _usedKeysPath = 'packages/functions/docs/used_keys.json';
const _docsPath = 'packages/functions';

Future<void> main() async {
  final currentProjectPath = Directory.current.path.replaceAll(
    '/packages/functions',
    '',
  );

  final enJsonData = <String, dynamic>{};
  final kyJsonData = <String, dynamic>{};
  final ruJsonData = <String, dynamic>{};
  final arJsonData = <String, dynamic>{};
  final idJsonData = <String, dynamic>{};
  final kkJsonData = <String, dynamic>{};
  final trJsonData = <String, dynamic>{};

  final [
    usedKeys,
    enJsonContent,
    arJsonContent,
    idJsonContent,
    kkJsonContent,
    kyJsonContent,
    ruJsonContent,
    trJsonContent,
  ] = await Future.wait<Map<String, dynamic>>([
    readJsonFile('$currentProjectPath/$_usedKeysPath'),
    readJsonFile('$currentProjectPath/$_enJsonPath'),
    readJsonFile('$currentProjectPath/$_arJsonPath'),
    readJsonFile('$currentProjectPath/$_idJsonPath'),
    readJsonFile('$currentProjectPath/$_kkJsonPath'),
    readJsonFile('$currentProjectPath/$_kyJsonPath'),
    readJsonFile('$currentProjectPath/$_ruJsonPath'),
    readJsonFile('$currentProjectPath/$_trJsonPath'),
  ]);

  for (final key in usedKeys.keys) {
    print('Start working for $key');
    enJsonData[key] = enJsonContent[key];
    kyJsonData[key] = kyJsonContent[key];
    ruJsonData[key] = ruJsonContent[key];
    arJsonData[key] = arJsonContent[key];
    idJsonData[key] = idJsonContent[key];
    kkJsonData[key] = kkJsonContent[key];
    trJsonData[key] = trJsonContent[key];
  }

  print('Finish all used keys');

  await createAndWriteJsonFile(
    '$currentProjectPath/$_enJsonPath',
    enJsonData,
  );

  await createAndWriteJsonFile(
    '$currentProjectPath/$_kyJsonPath',
    kyJsonData,
  );

  await createAndWriteJsonFile(
    '$currentProjectPath/$_ruJsonPath',
    ruJsonData,
  );

  await createAndWriteJsonFile(
    '$currentProjectPath/$_arJsonPath',
    arJsonData,
  );

  await createAndWriteJsonFile(
    '$currentProjectPath/$_idJsonPath',
    idJsonData,
  );

  await createAndWriteJsonFile(
    '$currentProjectPath/$_kkJsonPath',
    kkJsonData,
  );

  await createAndWriteJsonFile(
    '$currentProjectPath/$_trJsonPath',
    trJsonData,
  );

  if (!enJsonData.equal(enJsonContent)) {
    await createAndWriteJsonFile(
      '$currentProjectPath/$_docsPath/docs/old_en.json',
      enJsonContent,
    );
  }

  if (!kyJsonData.equal(kyJsonContent)) {
    await createAndWriteJsonFile(
      '$currentProjectPath/$_docsPath/docs/old_ky.json',
      kyJsonContent,
    );
  }

  if (!ruJsonData.equal(ruJsonContent)) {
    await createAndWriteJsonFile(
      '$currentProjectPath/$_docsPath/docs/old_ru.json',
      ruJsonContent,
    );
  }

  if (!arJsonData.equal(arJsonContent)) {
    await createAndWriteJsonFile(
      '$currentProjectPath/$_docsPath/docs/old_ar.json',
      arJsonContent,
    );
  }

  if (!idJsonData.equal(idJsonContent)) {
    await createAndWriteJsonFile(
      '$currentProjectPath/$_docsPath/docs/old_id.json',
      idJsonContent,
    );
  }

  if (!kkJsonData.equal(kkJsonContent)) {
    await createAndWriteJsonFile(
      '$currentProjectPath/$_docsPath/docs/old_kk.json',
      kkJsonContent,
    );
  }

  if (!trJsonData.equal(trJsonContent)) {
    await createAndWriteJsonFile(
      '$currentProjectPath/$_docsPath/docs/old_tr.json',
      trJsonContent,
    );
  }
}
