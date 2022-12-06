class JuzSurah {
  const JuzSurah({
    required this.name,
    required this.arName,
    required this.pages,
  });

  factory JuzSurah.fromMap(Map<String, dynamic> map) {
    return JuzSurah(
      name: map['name'] as String,
      arName: map['arName'] as String,
      pages: List<int>.from(map['pages'] as List<int>),
    );
  }

  final String name;
  final String arName;
  final List<int> pages;
}
