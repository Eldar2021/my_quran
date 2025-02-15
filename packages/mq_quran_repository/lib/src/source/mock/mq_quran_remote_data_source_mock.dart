import 'package:mq_quran_repository/mq_quran_repository.dart';

class MqQuranRemoteDataSourceMock implements MqQuranRemoteDataSource {
  const MqQuranRemoteDataSourceMock();

  @override
  Future<QuranDataResponse> fetchQuranByJuz(int juzNumber, String quranFmt) async {
    final data = {
      'verses': [
        {'id': 6226, 'verse_key': '113:1', quranFmt: 'قل اعوذ برب الفلق'},
        {'id': 6227, 'verse_key': '113:2', quranFmt: 'من شر ما خلق'},
        {'id': 6228, 'verse_key': '113:3', quranFmt: 'ومن شر غاسق اذا وقب'},
        {'id': 6229, 'verse_key': '113:4', quranFmt: 'ومن شر النفثت فى العقد'},
        {'id': 6230, 'verse_key': '113:5', quranFmt: 'ومن شر حاسد اذا حسد'},
        {'id': 6231, 'verse_key': '114:1', quranFmt: 'قل اعوذ برب الناس'},
        {'id': 6232, 'verse_key': '114:2', quranFmt: 'ملك الناس'},
        {'id': 6233, 'verse_key': '114:3', quranFmt: 'اله الناس'},
        {'id': 6234, 'verse_key': '114:4', quranFmt: 'من شر الوسواس الخناس'},
        {'id': 6235, 'verse_key': '114:5', quranFmt: 'الذى يوسوس فى صدور الناس'},
        {'id': 6236, 'verse_key': '114:6', quranFmt: 'من الجنة والناس'},
      ],
      'meta': {
        'filters': {'juz_number': '30'},
      },
    };

    await Future<void>.delayed(const Duration(seconds: 1));
    return QuranDataResponse.fromJson(data);
  }

  @override
  Future<QuranDataResponse> fetchQuranByPage(int pageNumber, String quranFmt) async {
    final data = {
      'verses': [
        {'id': 1, 'verse_key': '1:1', quranFmt: 'بسم الله الرحمن الرحيم'},
        {'id': 2, 'verse_key': '1:2', quranFmt: 'الحمد لله رب العلمين'},
        {'id': 3, 'verse_key': '1:3', quranFmt: 'الرحمن الرحيم'},
        {'id': 4, 'verse_key': '1:4', quranFmt: 'ملك يوم الدين'},
        {'id': 5, 'verse_key': '1:5', quranFmt: 'اياك نعبد واياك نستعين'},
        {'id': 6, 'verse_key': '1:6', quranFmt: 'اهدنا الصرط المستقيم'},
        {'id': 7, 'verse_key': '1:7', quranFmt: 'صرط الذين انعمت عليهم غير المغضوب عليهم ولا الضالين'},
      ],
      'meta': {
        'filters': {'page_number': '1'},
      },
    };

    await Future<void>.delayed(const Duration(seconds: 1));
    return QuranDataResponse.fromJson(data);
  }

  @override
  Future<QuranDataResponse> fetchQuranBySurah(int surahNumber, String quranFmt) async {
    final data = {
      'verses': [
        {'id': 1, 'verse_key': '1:1', quranFmt: 'بِسْمِ ٱللَّهِ ٱلرَّحْمَـٰنِ ٱلرَّحِيمِ'},
        {'id': 2, 'verse_key': '1:2', quranFmt: 'ٱلْحَمْدُ لِلَّهِ رَبِّ ٱلْعَـٰلَمِينَ'},
        {'id': 3, 'verse_key': '1:3', quranFmt: 'ٱلرَّحْمَـٰنِ ٱلرَّحِيمِ'},
        {'id': 4, 'verse_key': '1:4', quranFmt: 'مَـٰلِكِ يَوْمِ ٱلدِّينِ'},
        {'id': 5, 'verse_key': '1:5', quranFmt: 'إِيَّاكَ نَعْبُدُ وَإِيَّاكَ نَسْتَعِينُ'},
        {'id': 6, 'verse_key': '1:6', quranFmt: 'ٱهْدِنَا ٱلصِّرَٰطَ ٱلْمُسْتَقِيمَ'},
        {
          'id': 7,
          'verse_key': '1:7',
          quranFmt: 'صِرَٰطَ ٱلَّذِينَ أَنْعَمْتَ عَلَيْهِمْ غَيْرِ ٱلْمَغْضُوبِ عَلَيْهِمْ وَلَا ٱلضَّآلِّينَ',
        },
      ],
      'meta': {
        'filters': {'chapter_number': '1'},
      },
    };
    await Future<void>.delayed(const Duration(seconds: 1));
    return QuranDataResponse.fromJson(data);
  }
}
