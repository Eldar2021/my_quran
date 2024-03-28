import 'package:meta/meta.dart';
import 'package:my_quran/modules/modules.dart';

@immutable
final class JuzEntity {
  const JuzEntity({
    required this.id,
    required this.name,
    required this.pages,
    required this.surahs,
  });

  final int id;
  final String name;
  final List<int> pages;
  final List<JuzSurahEntity> surahs;
}
