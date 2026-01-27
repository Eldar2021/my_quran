// import 'dart:io';

// import 'package:functions/helper/helper.dart';

// class DayActivity {
//   const DayActivity({
//     required this.date,
//     required this.openedApp,
//     required this.quranReadedPagesCount,
//     required this.listenedQuranSeconds,
//     required this.fajrDone,
//     required this.zuhrDone,
//     required this.asrDone,
//     required this.maghribDone,
//     required this.ishaDone,
//   });

//   factory DayActivity.fromJson(Map<String, dynamic> json) {
//     return DayActivity(
//       date: DateTime.parse(json['date'] as String),
//       openedApp: json['openedApp'] as bool,
//       quranReadedPagesCount: json['quranReadedPagesCount'] as int,
//       listenedQuranSeconds: json['listenedQuranSeconds'] as double,
//       fajrDone: json['fajrDone'] as bool,
//       zuhrDone: json['zuhrDone'] as bool,
//       asrDone: json['asrDone'] as bool,
//       maghribDone: json['maghribDone'] as bool,
//       ishaDone: json['ishaDone'] as bool,
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'date': date.toIso8601String(),
//       'openedApp': openedApp,
//       'quranReadedPagesCount': quranReadedPagesCount,
//       'listenedQuranSeconds': listenedQuranSeconds,
//       'fajrDone': fajrDone,
//       'zuhrDone': zuhrDone,
//       'asrDone': asrDone,
//       'maghribDone': maghribDone,
//       'ishaDone': ishaDone,
//     };
//   }

//   final DateTime date;
//   final bool openedApp;
//   final int quranReadedPagesCount;
//   final double listenedQuranSeconds;
//   final bool fajrDone;
//   final bool zuhrDone;
//   final bool asrDone;
//   final bool maghribDone;
//   final bool ishaDone;

//   int get score {
//     var currentScore = 0;
//     if (openedApp) currentScore += 1;
//     if (quranReadedPagesCount > 0) currentScore += 1;
//     if (listenedQuranSeconds > 10) currentScore += 1;
//     if (fajrDone) currentScore += 1;
//     if (zuhrDone) currentScore += 1;
//     if (asrDone) currentScore += 1;
//     if (maghribDone) currentScore += 1;
//     if (ishaDone) currentScore += 1;
//     return currentScore;
//   }
// }

// void main(List<String> args) {
//   final currentProjectPath = Directory.current.path.replaceAll(
//     '/packages/functions',
//     '',
//   );
//   final activities = generateMockData();

//   createAndWriteListJsonFile(
//     '$currentProjectPath/$_docsPath/docs/activity.json',
//     activities.map((e) => e.toJson()).toList(),
//   );
// }

// List<DayActivity> generateMockData() {
//   final mocks = <DayActivity>[];
//   final startDate = DateTime.now();
//   for (var i = 0; i < 365; i++) {
//     final date = startDate.subtract(Duration(days: i));
//     mocks.add(
//       DayActivity(
//         date: date,
//         openedApp: i.isEven,
//         quranReadedPagesCount: i.isEven ? 12 : 0,
//         listenedQuranSeconds: i.isEven ? 600.0 : 0.0,
//         fajrDone: i.isEven,
//         zuhrDone: i.isEven,
//         asrDone: i.isEven,
//         maghribDone: i.isEven,
//         ishaDone: i.isEven,
//       ),
//     );
//   }
//   return mocks;
// }

// const _docsPath = 'packages/functions';
