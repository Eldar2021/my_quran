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
}
