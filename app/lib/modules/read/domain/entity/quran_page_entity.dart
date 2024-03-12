import 'package:meta/meta.dart';
import 'package:my_quran/constants/contants.dart';
import 'package:my_quran/modules/modules.dart';

@immutable
final class QuranPageEntity {
  const QuranPageEntity({
    required this.verses,
    required this.meta,
  });

  final List<VerseEnity> verses;
  final MetaEntity meta;

  StringBuffer get samePage {
    return StringBuffer()
      ..writeAll(
        verses.map(
          (e) =>
              '${e.isFirst ? '\n\n${AppStatic.bismallah.padLeft(50).padRight(50)}\n' : ''} ${e.textUthmani} ${e.hasSajda ? AppStatic.sajdaSymbol : ''} \uFD3F${e.ayatNumber.toArabicDigits}\uFD3E',
        ),
        '  ',
      );
  }
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
