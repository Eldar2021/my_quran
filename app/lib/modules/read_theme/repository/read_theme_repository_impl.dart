import 'package:meta/meta.dart';
import 'package:my_quran/modules/modules.dart';

@immutable
final class ReadThemeRepositoryImpl implements ReadThemeRepository {
  const ReadThemeRepositoryImpl(this.localThemeDataSource);

  final LocalThemeDataSourceImpl localThemeDataSource;

  @override
  ReadThemeData getInitialThemeState() {
    return localThemeDataSource.getInitialThemeState();
  }

  @override
  Future<void> saveThemeState(ReadThemeData themeState) {
    return localThemeDataSource.saveThemeState(themeState);
  }
}
