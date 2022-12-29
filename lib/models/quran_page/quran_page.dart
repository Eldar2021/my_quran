import 'package:hatim/models/models.dart';
import 'package:json_annotation/json_annotation.dart';

part 'quran_page.g.dart';

@JsonSerializable()
class QuranPage {
  const QuranPage({required this.verses, required this.meta});

  factory QuranPage.fromJson(Map<String, dynamic> json) => _$QuranPageFromJson(json);
  Map<String, dynamic> toJson() => _$QuranPageToJson(this);

  final List<Verse> verses;
  final Meta meta;

  StringBuffer get samePage {
    return StringBuffer()..writeAll(verses.map((e) => '${e.textUthmani} \u06dd${e.ayatNumber.toArabicDigits()} '), ' ');
  }
}

extension NumberConverter on num {
  static const Map<String, String> arabicDigits = <String, String>{
    '0': '\u0660',
    '1': '\u0661',
    '2': '\u0662',
    '3': '\u0663',
    '4': '\u0664',
    '5': '\u0665',
    '6': '\u0666',
    '7': '\u0667',
    '8': '\u0668',
    '9': '\u0669',
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
