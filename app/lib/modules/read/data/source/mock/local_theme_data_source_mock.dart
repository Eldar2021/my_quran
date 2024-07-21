import 'package:meta/meta.dart';

import 'package:my_quran/modules/modules.dart';

@immutable
final class LocalThemeDataSourceMock implements LocalThemeDataSource {
  const LocalThemeDataSourceMock();

  @override
  ReadThemeState get initialTheme {
    return const ReadThemeState();
  }

  @override
  Future<void> saveThemeState(ReadThemeState themeState) => Future.value();
}
