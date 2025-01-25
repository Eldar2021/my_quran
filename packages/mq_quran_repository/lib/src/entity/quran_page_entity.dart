import 'package:flutter/material.dart';
import 'package:mq_quran_repository/mq_quran_repository.dart';

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
          (e) {
            final bismillahCentered = e.isFirst ? '\n\n${centerText(MqQuranStatic.bismallah)}\n' : '';
            final sajdaSymbol = e.hasSajda ? MqQuranStatic.sajdaSymbol : '';
            return '$bismillahCentered ${e.textUthmani} $sajdaSymbol \uFD3F${e.ayatNumber.toArabicDigits}\uFD3E';
          },
        ),
        '  ',
      );
  }

  String centerText(String text, {int lineWidth = 50}) {
    final totalPadding = lineWidth - text.length;
    if (totalPadding <= 0) return text;

    final leftPadding = totalPadding ~/ 1;
    final rightPadding = totalPadding - leftPadding;

    return ' ' * leftPadding + text + ' ' * rightPadding;
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
