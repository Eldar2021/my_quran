import 'package:meta/meta.dart';

@immutable
class DayActivity {
  const DayActivity({
    required this.date,
    required this.openedApp,
    required this.quranReadedPagesCount,
    required this.listenedQuranSeconds,
    required this.fajrDone,
    required this.zuhrDone,
    required this.asrDone,
    required this.maghribDone,
    required this.ishaDone,
  });

  factory DayActivity.fromJson(Map<String, dynamic> json) {
    return DayActivity(
      date: DateTime.parse(json['date'] as String),
      openedApp: json['openedApp'] as bool,
      quranReadedPagesCount: json['quranReadedPagesCount'] as int,
      listenedQuranSeconds: json['listenedQuranSeconds'] as double,
      fajrDone: json['fajrDone'] as bool,
      zuhrDone: json['zuhrDone'] as bool,
      asrDone: json['asrDone'] as bool,
      maghribDone: json['maghribDone'] as bool,
      ishaDone: json['ishaDone'] as bool,
    );
  }

  final DateTime date;
  final bool openedApp;
  final int quranReadedPagesCount;
  final double listenedQuranSeconds;
  final bool fajrDone;
  final bool zuhrDone;
  final bool asrDone;
  final bool maghribDone;
  final bool ishaDone;

  int get score {
    var currentScore = 0;
    if (openedApp) currentScore += 1;
    if (quranReadedPagesCount > 0) currentScore += 1;
    if (listenedQuranSeconds > 10) currentScore += 1;
    if (fajrDone) currentScore += 1;
    if (zuhrDone) currentScore += 1;
    if (asrDone) currentScore += 1;
    if (maghribDone) currentScore += 1;
    if (ishaDone) currentScore += 1;
    return currentScore;
  }

  static List<DayActivity> fillYearlyData(List<DayActivity> activities) {
    if (activities.isEmpty) return [];
    final fullYear = <DayActivity>[];
    final firstDateInRecords = activities.map((e) => e.date).reduce((a, b) => a.isBefore(b) ? a : b);
    final startDate = DateTime(firstDateInRecords.year, firstDateInRecords.month, firstDateInRecords.day);
    final activityMap = {for (final a in activities) DateTime(a.date.year, a.date.month, a.date.day): a};
    for (var i = 0; i < 365; i++) {
      final targetDate = startDate.add(Duration(days: i));
      if (activityMap.containsKey(targetDate)) {
        fullYear.add(activityMap[targetDate]!);
      } else {
        fullYear.add(
          DayActivity(
            date: targetDate,
            openedApp: false,
            quranReadedPagesCount: 0,
            listenedQuranSeconds: 0,
            fajrDone: false,
            zuhrDone: false,
            asrDone: false,
            maghribDone: false,
            ishaDone: false,
          ),
        );
      }
    }
    return fullYear.toList();
  }

  static Map<DateTime, List<DayActivity>> groupByMonth(List<DayActivity> activities) {
    final grouped = <DateTime, List<DayActivity>>{};
    for (final activity in activities) {
      final month = DateTime(activity.date.year, activity.date.month);
      if (!grouped.containsKey(month)) {
        grouped[month] = [];
      }
      grouped[month]!.add(activity);
    }
    return grouped;
  }

  static List<DayActivity> generateMockData() {
    final mocks = <DayActivity>[];
    final startDate = DateTime.now().subtract(const Duration(days: 365));
    for (var i = 0; i < 90; i++) {
      final date = startDate.add(Duration(days: i));
      mocks.add(
        DayActivity(
          date: date,
          openedApp: true,
          quranReadedPagesCount: (i % 3 == 0) ? (i % 5 + 1) : 0,
          listenedQuranSeconds: (i.isEven) ? 600.0 : 0.0,
          fajrDone: i % 7 != 0,
          zuhrDone: true,
          asrDone: i % 4 != 0,
          maghribDone: true,
          ishaDone: true,
        ),
      );
    }
    return mocks;
  }
}
