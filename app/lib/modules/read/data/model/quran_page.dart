import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:my_quran/constants/contants.dart';
import 'package:my_quran/modules/modules.dart';
part 'quran_page.g.dart';

@immutable
@JsonSerializable()
final class QuranPage {
  const QuranPage({required this.verses, required this.meta});

  factory QuranPage.fromJson(Map<String, dynamic> json) => _$QuranPageFromJson(json);
  Map<String, dynamic> toJson() => _$QuranPageToJson(this);

  final List<Verse> verses;
  final Meta meta;

  StringBuffer get samePage {
    return StringBuffer()
      ..writeAll(
        verses.map(
          (e) =>
              '${e.isFirst ? '\n\n${AppConst.bismallah.padLeft(50).padRight(50)}\n' : ''} ${e.textUthmani} ${e.hasSajda ? AppConst.sajdaSymbol : ''} \uFD3F${e.ayatNumber.toArabicDigits}\uFD3E',
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
