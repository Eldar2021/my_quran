// NOTE
// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';

Future<void> createAndWriteJsonFile(
  String filePath,
  Map<String, dynamic> data,
) async {
  try {
    final file = File(filePath);
    final jsonString = const JsonEncoder.withIndent('  ').convert(data);
    if (!file.existsSync()) {
      await file.create(recursive: true);
    }
    await file.writeAsString(jsonString);
    print('JSON file created and written: $filePath');
  } on Exception catch (e) {
    print('Error creating and writing JSON file: $e');
    rethrow;
  }
}

Future<Map<String, dynamic>> readJsonFile(String filePath) async {
  try {
    final file = File(filePath);
    final contents = await file.readAsString();
    final jsonData = json.decode(contents) as Map<String, dynamic>;
    return jsonData;
  } catch (e) {
    print('Error reading file: $e');
    rethrow;
  }
}

Future<List<FileSystemEntity>> readAllFilesInDirectory(
  String directoryPath, {
  String? extension,
}) async {
  try {
    final directory = Directory(directoryPath);
    if (!directory.existsSync()) {
      throw Exception('No directory found: $directoryPath');
    }
    final allFiles = <File>[];
    await for (final entity in directory.list(recursive: true)) {
      if (entity is File) {
        if ((extension == null || entity.path.endsWith(extension)) && !entity.path.endsWith('.g.dart')) {
          allFiles.add(entity);
        }
      }
    }
    return allFiles;
  } catch (e) {
    print('Error reading directory: $e');
    rethrow;
  }
}

extension MapExtension<K, V> on Map<K, V> {
  bool equal(Map<K, V> other) {
    if (length != other.length) {
      return false;
    }
    for (final key in keys) {
      if (!containsKey(key) || other[key] != other[key]) {
        return false;
      }
    }
    return true;
  }
}
