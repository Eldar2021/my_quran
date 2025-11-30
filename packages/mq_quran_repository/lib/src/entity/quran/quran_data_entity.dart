import 'package:flutter/material.dart';
import 'package:mq_quran_repository/mq_quran_repository.dart';

@immutable
final class QuranDataEntity {
  const QuranDataEntity({
    required this.verses,
    required this.meta,
  });

  final List<QuranDataVerseEntity> verses;
  final QuranDataMetaEntity meta;

  List<QuranDataSamePage> dataDatePage() {
    final groupedVerses = <int, List<QuranDataVerseEntity>>{};

    final parsedPageEndings = MqQuranStatic.pagesEnded.map((
      page,
      endVerseKey,
    ) {
      final parts = endVerseKey.split(':').map(int.parse);
      return MapEntry(page, (parts.first, parts.last));
    });

    var currentPage = 1;

    for (final verse in verses) {
      final parts = verse.verseKey.split(':').map(int.parse).toList();
      final surah = parts[0];
      final ayah = parts[1];

      while (parsedPageEndings[currentPage] != null &&
          (surah > parsedPageEndings[currentPage]!.$1 ||
              (surah == parsedPageEndings[currentPage]!.$1 && ayah > parsedPageEndings[currentPage]!.$2))) {
        currentPage++;
      }

      groupedVerses.update(currentPage, (list) {
        return list..add(verse);
      }, ifAbsent: () => [verse]);
    }

    return groupedVerses.entries
        .map(
          (entry) => QuranDataSamePage(
            pageNumber: entry.key,
            verses: entry.value,
          ),
        )
        .toList();
  }
}

@immutable
final class QuranDataMetaEntity {
  const QuranDataMetaEntity({
    required this.filters,
  });

  final QuranDataFilterEntity filters;
}

@immutable
final class QuranDataSamePage {
  const QuranDataSamePage({
    required this.pageNumber,
    required this.verses,
  });

  final int pageNumber;
  final List<QuranDataVerseEntity> verses;

  bool isFirst(String key) => verses.first.verseKey == key;
}

extension NumberConverter on num {
  static const Map<String, String> arabicDigits = <String, String>{
    '0': '٠',
    '1': '١',
    '2': '٢',
    '3': '٣',
    '4': '٤',
    '5': '٥',
    '6': '٦',
    '7': '٧',
    '8': '٨',
    '9': '٩',
  };

  String get toArabicDigits {
    final number = toString();
    final sb = StringBuffer();
    for (var i = 0; i < number.length; i++) {
      sb.write(arabicDigits[number[i]] ?? number[i]);
    }
    return sb.toString();
  }
}
