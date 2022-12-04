class Surah {
  const Surah({
    required this.id,
    required this.name,
    required this.aya,
    required this.pages,
    required this.arabic,
  });

  factory Surah.fromMap(Map<String, dynamic> map) {
    return Surah(
      id: map['id'] as int,
      name: map['name'] as String,
      aya: map['aya'] as int,
      pages: List<int>.from(map['pages'] as List<int>),
      arabic: map['arabic'] as String,
    );
  }

  final int id;
  final String name;
  final int aya;
  final List<int> pages;
  final String arabic;
}
