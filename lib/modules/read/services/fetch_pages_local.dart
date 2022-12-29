import 'package:hatim/core/core.dart';

class HatimReadService {
  const HatimReadService(this.storage);

  final AppCache<List<int>> storage;

  static const String _pages = 'page';
  static const String _lastPage = 'lats_page';

  List<int>? getPages() {
    final pages = storage.read(key: _pages);
    return pages;
  }

  int? getLatPage() {
    final pages = storage.read(key: _lastPage);
    return pages?.first;
  }

  Future<void> setPages(List<int> pages) async {
    await storage.save(key: _pages, value: pages);
  }

  Future<void> setLastPage(int lastPage) async {
    await storage.save(key: _lastPage, value: [lastPage]);
  }

  Future<void> clear() async => storage.clear();

  String get pagesKey => _pages;

  String get lastPageKey => _lastPage;
}
