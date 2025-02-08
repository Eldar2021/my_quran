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

    final parsedPageEndings = MqQuranStatic.pagesEnded.map(
      (page, endVerseKey) {
        final parts = endVerseKey.split(':').map(int.parse);
        return MapEntry(page, (parts.first, parts.last));
      },
    );

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

      groupedVerses.update(
        currentPage,
        (list) => list..add(verse),
        ifAbsent: () => [verse],
      );
    }

    return groupedVerses.entries
        .map(
          (entry) => QuranDataSamePage(pageNumber: entry.key, verses: entry.value),
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

  StringBuffer get samePage {
    return StringBuffer()
      ..writeAll(
        verses.map(
          (e) {
            final a = e.text.replaceAll('\u{06DF}', '\u{0652}');
            final sajdaSymbol = e.hasSajda ? MqQuranStatic.sajdaSymbol : '';
            return '$a $sajdaSymbol\uFD3F${e.ayatNumber.toArabicDigits}\uFD3E  ';
          },
        ),
      );
  }
}
