import 'package:meta/meta.dart';
import 'package:my_quran/modules/modules.dart';

@immutable
final class ReadThemeRepositoryImpl implements ReadThemeRepository {
  const ReadThemeRepositoryImpl(this.localThemeDataSource);

  final LocalThemeDataSourceImpl localThemeDataSource;

  @override
  ReadThemeState get getInitialThemeState {
    return localThemeDataSource.initialTheme;
  }

  @override
  Future<void> saveThemeState(ReadThemeState themeState) async {
    return localThemeDataSource.saveThemeState(themeState);
  }
}
