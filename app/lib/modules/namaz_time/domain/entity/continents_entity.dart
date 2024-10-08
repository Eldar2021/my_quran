import 'package:meta/meta.dart';
import 'package:my_quran/modules/modules.dart';

@immutable
final class ContinentsEntity {
  const ContinentsEntity({required this.list});

  final List<Continent> list;
}

// @immutable
// final class Continent {
//   const Continent({
//     required this.id,
//     required this.title,
//     required this.titleRu,
//     required this.titleEn,
//     required this.parentId,
//     required this.createdAt,
//     required this.updatedAt,
//   });

//   final int id;
//   final String title;
//   final String titleRu;
//   final String titleEn;
//   final int parentId;
//   final String createdAt;
//   final String updatedAt;
// }
