import 'package:my_quran/modules/modules.dart';

class ReadThemeRepositoryImpl implements ReadThemeRepository {
  const ReadThemeRepositoryImpl({required this.localDataSource});
  final LocalThemeDataSource localDataSource;

  @override
  Future<ReadThemeState> getInitialThemeState() async {
    return localDataSource.getInitialThemeState();
  }

  @override
  Future<void> saveThemeState(ReadThemeState themeState) async {
    return localDataSource.saveThemeState(themeState);
  }
}
