import 'package:meta/meta.dart';
import 'package:my_quran/constants/contants.dart';

@immutable
final class VerseEnity {
  const VerseEnity({
    required this.id,
    required this.verseKey,
    required this.textUthmani,
  });

  final int id;
  final String verseKey;
  final String textUthmani;

  int get juzNumber => int.parse(verseKey.split(':').first);
  int get ayatNumber => int.parse(verseKey.split(':').last);
  bool get isFirst => ayatNumber == 1;
  bool get hasSajda => AppConst.sajdaAyats.contains(id);
}
