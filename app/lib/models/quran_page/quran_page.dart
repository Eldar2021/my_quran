import 'package:json_annotation/json_annotation.dart';

import 'package:my_quran/constants/contants.dart';
import 'package:my_quran/models/models.dart';

part 'quran_page.g.dart';

@JsonSerializable()
class QuranPage {
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
              '${e.isFirst ? '\n\n${AppConst.bismallah.padLeft(50).padRight(50)}\n' : ''} ${e.textUthmani} \uFD3F${e.ayatNumber.toArabicDigits()}\uFD3E',
        ),
        '  ',
      );
  }
}

extension NumberConverter on num {
  static const Map<String, String> arabicDigits = <String, String>{
    '0': '۰',
    '1': '۱',
    '2': '۲',
    '3': '۳',
    '4': '۴',
    '5': '۵',
    '6': '۶',
    '7': '۷',
    '8': '۸',
    '9': '۹',
  };

  String toArabicDigits() {
    final number = toString();
    final sb = StringBuffer();
    for (var i = 0; i < number.length; i++) {
      sb.write(arabicDigits[number[i]] ?? number[i]);
    }
    return sb.toString();
  }
}
