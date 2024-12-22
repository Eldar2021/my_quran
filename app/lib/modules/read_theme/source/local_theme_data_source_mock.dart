import 'package:meta/meta.dart';
import 'package:my_quran/modules/modules.dart';

@immutable
final class LocalThemeDataSourceMock implements LocalThemeDataSource {
  const LocalThemeDataSourceMock();

  @override
  ReadThemeData getInitialThemeState() {
    return ReadThemeData.initial;
  }

  @override
  Future<void> saveThemeState(ReadThemeData themeState) {
    return Future.value();
  }
}
