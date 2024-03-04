import 'dart:developer';

import 'package:my_quran/modules/modules.dart';

class ReadRepositoryImpl implements ReadRepository {
  const ReadRepositoryImpl(this.remoteDataSource, this.localDataSource);

  final ReadRemoteDataSource remoteDataSource;
  final ReadLocalDataSource localDataSource;

  @override
  Future<QuranPage?> getPage(int page, String quranFmt) async {
    try {
      final localPage = await localDataSource.getPage(page, quranFmt);
      final remotePage = await remoteDataSource.fetchPage(page, quranFmt);
      if (remotePage != null) {
        await localDataSource.cachePage(page, quranFmt, remotePage);
        return remotePage;
      }
      if (localPage != null) {
        return localPage;
      }
    } catch (e) {
      log('Error fetching page locally and remotely: $e');
    }
    return null;
  }
}
