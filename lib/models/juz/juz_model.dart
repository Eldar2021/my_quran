import 'package:hatim/models/juz/juz_surah_model.dart';

class Juz {
  const Juz({
    required this.id,
    required this.name,
    required this.pages,
    required this.surahs,
  });

  factory Juz.fromMap(Map<String, dynamic> map) {
    return Juz(
      id: map['id'] as int,
      name: map['name'] as String,
      pages: List<int>.from(map['pages'] as List<int>),
      surahs: List<JuzSurah>.from(
        (map['surahs'] as List).map<JuzSurah>(
          (x) => JuzSurah.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  final int id;
  final String name;
  final List<int> pages;
  final List<JuzSurah> surahs;
}
