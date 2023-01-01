import 'package:hatim/core/cache/app_cache.dart';
import 'package:hatim/modules/read/logic/read_theme_cubit.dart';

class ReadThemeService {
  const ReadThemeService(this.storage);

  final AppCache<int> storage;

  static const _textSize = 'textSize';
  static const _verticalSpace = 'verticalSpace';
  static const _horizontallSace = 'horizontallSace';
  static const _modeIndex = 'modeIndex';

  ReadTheme init() {
    final textSize = storage.read(key: _textSize);
    final verticalSpace = storage.read(key: _verticalSpace);
    final horizontallSace = storage.read(key: _horizontallSace);
    final modeIndex = storage.read(key: _modeIndex);
    return ReadTheme(
      textSize: textSize ?? 18,
      verticalSpace: verticalSpace ?? 0,
      horizontalSpace: horizontallSace ?? 14,
      modeIndex: modeIndex ?? 1,
    );
  }

  Future<void> saveChanges(ReadTheme theme) async {
    await storage.save(key: _textSize, value: theme.textSize);
    await storage.save(key: _verticalSpace, value: theme.verticalSpace);
    await storage.save(key: _horizontallSace, value: theme.horizontalSpace);
    await storage.save(key: _modeIndex, value: theme.modeIndex);
  }
}
