class QuranExModel {
  const QuranExModel({
    required this.verses,
    required this.meta,
  });

  factory QuranExModel.fromJson(Map<String, dynamic> json) => QuranExModel(
    verses: List<Verse>.from(
      (json['verses'] as List<dynamic>).map(
        (x) => Verse.fromJson(x as Map<String, dynamic>),
      ),
    ),
    meta: Meta.fromJson(json['meta'] as Map<String, dynamic>),
  );

  final List<Verse> verses;
  final Meta meta;
}

class Meta {
  const Meta(this.filters);

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    Filters.fromJson(json['filters'] as Map<String, dynamic>),
  );

  final Filters filters;
}

class Filters {
  const Filters(this.chapterNumber);

  factory Filters.fromJson(Map<String, dynamic> json) => Filters(
    json['chapter_number'] as String,
  );

  final String chapterNumber;
}

class Verse {
  const Verse({
    required this.id,
    required this.verseKey,
    required this.codeV2,
    required this.v2Page,
  });

  factory Verse.fromJson(Map<String, dynamic> json) => Verse(
    id: json['id'] as int,
    verseKey: json['verse_key'] as String,
    codeV2: json['code_v2'] as String,
    v2Page: json['v2_page'] as int,
  );

  final int id;
  final String verseKey;
  final String codeV2;
  final int v2Page;
}

const Map<String, Object> exData = {
  'verses': [
    {'id': 1, 'verse_key': '1:1', 'code_v2': 'ﱁ ﱂ ﱃ ﱄ ﱅ', 'v2_page': 1},
    {'id': 2, 'verse_key': '1:2', 'code_v2': 'ﱆ ﱇ ﱈ ﱉ ﱊ', 'v2_page': 1},
    {'id': 3, 'verse_key': '1:3', 'code_v2': 'ﱋ ﱌ ﱍ', 'v2_page': 1},
    {'id': 4, 'verse_key': '1:4', 'code_v2': 'ﱎ ﱏ ﱐ ﱑ', 'v2_page': 1},
    {'id': 5, 'verse_key': '1:5', 'code_v2': 'ﱒ ﱓ ﱔ ﱕ ﱖ', 'v2_page': 1},
    {'id': 6, 'verse_key': '1:6', 'code_v2': 'ﱗ ﱘ ﱙ ﱚ', 'v2_page': 1},
    {'id': 7, 'verse_key': '1:7', 'code_v2': 'ﱛ ﱜ ﱝ ﱞ ﱟ ﱠ ﱡ ﱢ ﱣ ﱤ', 'v2_page': 1},
  ],
  'meta': {
    'filters': {'chapter_number': '1'},
  },
};
