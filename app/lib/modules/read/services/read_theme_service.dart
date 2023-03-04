import 'package:mq_storage/mq_storage.dart';
import 'package:my_quran/modules/read/logic/read_theme_cubit.dart';

class ReadThemeService {
  const ReadThemeService(this.storage);

  final PreferencesStorage storage;

  static const _textSize = 'textSize';
  static const _verticalSpace = 'verticalSpace';
  static const _horizontallSace = 'horizontallSace';
  static const _modeIndex = 'modeIndex';

  ReadTheme init() {
    final textSize = storage.readInt(key: _textSize);
    final verticalSpace = storage.readInt(key: _verticalSpace);
    final horizontallSace = storage.readInt(key: _horizontallSace);
    final modeIndex = storage.readInt(key: _modeIndex);
    return ReadTheme(
      textSize: textSize ?? 22,
      verticalSpace: verticalSpace ?? 0,
      horizontalSpace: horizontallSace ?? 14,
      modeIndex: modeIndex ?? 1,
    );
  }

  Future<void> saveChanges(ReadTheme theme) async {
    await storage.writeInt(key: _textSize, value: theme.textSize);
    await storage.writeInt(key: _verticalSpace, value: theme.verticalSpace);
    await storage.writeInt(key: _horizontallSace, value: theme.horizontalSpace);
    await storage.writeInt(key: _modeIndex, value: theme.modeIndex);
  }
}
