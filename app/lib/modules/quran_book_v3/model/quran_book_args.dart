import 'package:flutter/cupertino.dart';
import 'package:mq_quran_repository/mq_quran_repository.dart';

@immutable
sealed class QuranBookArgs {
  const QuranBookArgs();

  List<int> get pages;
}

@immutable
final class QuranFullArgs extends QuranBookArgs {
  const QuranFullArgs();

  @override
  List<int> get pages {
    return List.generate(604, (i) => i + 1);
  }
}

@immutable
final class QuranByPageArgs extends QuranBookArgs {
  const QuranByPageArgs(this.pages);

  @override
  final List<int> pages;
}

@immutable
final class QuranBySurahArgs extends QuranBookArgs {
  const QuranBySurahArgs(this.surahNumber);

  final int surahNumber;

  @override
  List<int> get pages {
    final range = surahRanges[surahNumber];
    if (range == null) return [1];
    final (startPage, endPage) = range;
    if (startPage > endPage) return [startPage];
    return List.generate(
      endPage - startPage + 1,
      (index) => startPage + index,
    );
  }
}

@immutable
final class QuranByJuzArgs extends QuranBookArgs {
  const QuranByJuzArgs(this.juzNumber);

  final int juzNumber;

  @override
  List<int> get pages {
    final range = juzPages[juzNumber];
    if (range == null) return [1];
    final (startPage, endPage) = range;
    if (startPage > endPage) return [startPage];
    return List.generate(
      endPage - startPage + 1,
      (index) => startPage + index,
    );
  }
}
