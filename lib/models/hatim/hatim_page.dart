class HatimPage {
  const HatimPage({
    required this.id,
    required this.status,
  });

  factory HatimPage.fromJson(Map<String, dynamic> map) {
    return HatimPage(
      id: map['id'] as int,
      status: PageStatus.values.byName(map['status'] as String),
    );
  }

  final int id;
  final PageStatus status;
}

enum PageStatus { empty, process, done }

final hatimPageMockData = [
  {'id': 1, 'status': 'empty'},
  {'id': 2, 'status': 'empty'},
  {'id': 3, 'status': 'empty'},
  {'id': 4, 'status': 'empty'},
  {'id': 5, 'status': 'empty'},
  {'id': 6, 'status': 'process'},
  {'id': 7, 'status': 'process'},
  {'id': 8, 'status': 'process'},
  {'id': 9, 'status': 'process'},
  {'id': 10, 'status': 'process'},
  {'id': 11, 'status': 'process'},
  {'id': 12, 'status': 'process'},
  {'id': 13, 'status': 'process'},
  {'id': 14, 'status': 'done'},
  {'id': 15, 'status': 'done'},
  {'id': 16, 'status': 'done'},
  {'id': 17, 'status': 'done'},
  {'id': 18, 'status': 'done'},
  {'id': 19, 'status': 'done'},
  {'id': 20, 'status': 'done'},
];
