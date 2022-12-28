class Verse {
  const Verse({
    required this.id,
    required this.verseKey,
    required this.textUthmani,
  });

  factory Verse.fromMap(Map<String, dynamic> map) {
    return Verse(
      id: map['id'] as int,
      verseKey: map['verse_key'] as String,
      textUthmani: map['text_uthmani'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'verse_key': verseKey,
      'text_uthmani': textUthmani,
    };
  }

  final int id;
  final String verseKey;
  final String textUthmani;

  int get juzNumber => int.parse(verseKey.split(':').first);
  int get surahNumber => int.parse(verseKey.split(':').last);
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
