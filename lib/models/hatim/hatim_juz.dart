class HatimJus {
  const HatimJus({
    required this.id,
    required this.name,
    required this.emptyPersent,
    required this.processPersent,
    required this.donePercent,
  });

  factory HatimJus.fromJson(Map<String, dynamic> map) {
    return HatimJus(
      id: map['id'] as int,
      name: map['name'] as String,
      emptyPersent: map['emptyPersent'] as num,
      processPersent: map['processPersent'] as num,
      donePercent: map['donePercent'] as num,
    );
  }

  final int id;
  final String name;
  final num emptyPersent;
  final num processPersent;
  final num donePercent;
}

const hatimJuzMockData = [
  {
    'id': 1,
    'name': 'آلم',
    'emptyPersent': 17,
    'processPersent': 43,
    'donePercent': 40,
  },
  {
    'id': 2,
    'name': 'آلم',
    'emptyPersent': 17,
    'processPersent': 43,
    'donePercent': 40,
  },
  {
    'id': 3,
    'name': 'آلم',
    'emptyPersent': 17,
    'processPersent': 43,
    'donePercent': 40,
  },
  {
    'id': 4,
    'name': 'آلم',
    'emptyPersent': 17,
    'processPersent': 43,
    'donePercent': 40,
  },
  {
    'id': 5,
    'name': 'آلم',
    'emptyPersent': 17,
    'processPersent': 43,
    'donePercent': 40,
  },
  {
    'id': 6,
    'name': 'آلم',
    'emptyPersent': 17,
    'processPersent': 43,
    'donePercent': 40,
  },
  {
    'id': 7,
    'name': 'آلم',
    'emptyPersent': 17,
    'processPersent': 43,
    'donePercent': 40,
  },
  {
    'id': 8,
    'name': 'آلم',
    'emptyPersent': 17,
    'processPersent': 43,
    'donePercent': 40,
  },
  {
    'id': 9,
    'name': 'آلم',
    'emptyPersent': 17,
    'processPersent': 43,
    'donePercent': 40,
  },
  {
    'id': 10,
    'name': 'آلم',
    'emptyPersent': 17,
    'processPersent': 43,
    'donePercent': 40,
  },
  {
    'id': 11,
    'name': 'آلم',
    'emptyPersent': 17,
    'processPersent': 43,
    'donePercent': 40,
  },
  {
    'id': 12,
    'name': 'آلم',
    'emptyPersent': 17,
    'processPersent': 43,
    'donePercent': 40,
  },
  {
    'id': 13,
    'name': 'آلم',
    'emptyPersent': 17,
    'processPersent': 43,
    'donePercent': 40,
  },
  {
    'id': 14,
    'name': 'آلم',
    'emptyPersent': 17,
    'processPersent': 43,
    'donePercent': 40,
  },
  {
    'id': 15,
    'name': 'آلم',
    'emptyPersent': 17,
    'processPersent': 43,
    'donePercent': 40,
  },
  {
    'id': 16,
    'name': 'آلم',
    'emptyPersent': 17,
    'processPersent': 43,
    'donePercent': 40,
  },
  {
    'id': 17,
    'name': 'آلم',
    'emptyPersent': 17,
    'processPersent': 43,
    'donePercent': 40,
  },
  {
    'id': 18,
    'name': 'آلم',
    'emptyPersent': 17,
    'processPersent': 43,
    'donePercent': 40,
  },
  {
    'id': 19,
    'name': 'آلم',
    'emptyPersent': 17,
    'processPersent': 43,
    'donePercent': 40,
  },
  {
    'id': 20,
    'name': 'آلم',
    'emptyPersent': 17,
    'processPersent': 43,
    'donePercent': 40,
  },
  {
    'id': 21,
    'name': 'آلم',
    'emptyPersent': 17,
    'processPersent': 43,
    'donePercent': 40,
  },
  {
    'id': 22,
    'name': 'آلم',
    'emptyPersent': 17,
    'processPersent': 43,
    'donePercent': 40,
  },
  {
    'id': 23,
    'name': 'آلم',
    'emptyPersent': 17,
    'processPersent': 43,
    'donePercent': 40,
  },
  {
    'id': 24,
    'name': 'آلم',
    'emptyPersent': 17,
    'processPersent': 43,
    'donePercent': 40,
  },
  {
    'id': 25,
    'name': 'آلم',
    'emptyPersent': 17,
    'processPersent': 43,
    'donePercent': 40,
  },
  {
    'id': 26,
    'name': 'آلم',
    'emptyPersent': 17,
    'processPersent': 43,
    'donePercent': 40,
  },
  {
    'id': 27,
    'name': 'آلم',
    'emptyPersent': 17,
    'processPersent': 43,
    'donePercent': 40,
  },
  {
    'id': 28,
    'name': 'آلم',
    'emptyPersent': 17,
    'processPersent': 43,
    'donePercent': 40,
  },
  {
    'id': 29,
    'name': 'آلم',
    'emptyPersent': 17,
    'processPersent': 43,
    'donePercent': 40,
  },
  {
    'id': 30,
    'name': 'آلم',
    'emptyPersent': 17,
    'processPersent': 43,
    'donePercent': 40,
  },
];
