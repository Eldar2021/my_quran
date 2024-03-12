import 'package:meta/meta.dart';

@immutable
final class AppStatic {
  const AppStatic._();

  static const bismallah = 'بِسْمِ ٱللَّهِ ٱلرَّحْمَـٰنِ ٱلرَّحِيمِ';
  static const sajdaSymbol = '۩';
  static const sajdaAyats = [
    1160,
    1722,
    1951,
    2138,
    2308,
    2613,
    2672,
    2915,
    3185,
    3518,
    3994,
    4256,
    4846,
    5905,
    6125,
  ];

  /* 
  yes - https://api.quran.com/api/v4/quran/verses/uthmanit?page_number=1 has sajda symbol ۩
  correct - check from mushaf
  1. 1160(ayat id) - 176 page - аль-Араф:206 (yes) (correct)
  2. 1722(ayat id) - 251 page - ар-Рад:15 (yes) (correct)
  3. 1951(ayat id) - 272 page - ан-Нахль:50 (yes) (correct)
  4. 2138(ayat id) - 293 page - аль-Исра:109  (yes) (correct)
  5. 2308(ayat id) - 309 page - Марьям:58 (yes) (correct)
  6. 2613(ayat id) - 334 page - аль-Хадж:18 (yes) (correct)
  7. 2672(ayat id) - 341 page - аль-Хадж:77 (yes) (correct)
  8. 2915(ayat id) - 365 page - аль-Фуркан:60 (yes) (correct)
  9. 3185(ayat id) - 379 page - ан-Намль:26 (yes) (correct)
  10. 3518(ayat id) - 416 page - ас-Сажда:15 (yes) (correct)
  11. 3994(ayat id) - 454 page - Сад:24 (yes) (correct)
  12. 4256(ayat id) - 480 page - Фуссилят:38 (yes) (correct)
  13. 4846(ayat id) - 528 page - ан-Наджм:62 (yes) (correct)
  14. 5905(ayat id) - 589 page - аль-Иншикак:21 (yes) (correct)
  16. 6125(ayat id) - 597 page - аль-Аляк:19 (yes) (correct)
  */
}
