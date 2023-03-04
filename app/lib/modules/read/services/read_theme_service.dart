import 'package:mq_storage/mq_storage.dart';
import 'package:my_quran/constants/contants.dart';
import 'package:my_quran/modules/read/logic/read_theme_cubit.dart';

class ReadThemeService {
  const ReadThemeService(this.storage);

  final PreferencesStorage storage;

  ReadTheme init() {
    final textSize = storage.readInt(key: AppConst.textSizeKey);
    final verticalSpaceSize = storage.readInt(key: AppConst.verticalSpaceKey);
    final horizontallSpaceSize = storage.readInt(key: AppConst.horizontallSaceKey);
    final modeIndex = storage.readInt(key: AppConst.modeIndexKey);
    return ReadTheme(
      textSize: textSize ?? 22,
      verticalSpaceSize: verticalSpaceSize ?? 0,
      horizontalSpaceSize: horizontallSpaceSize ?? 14,
      modeIndex: modeIndex ?? 1,
    );
  }

  Future<void> saveChanges(ReadTheme theme) async {
    await storage.writeInt(key: AppConst.textSizeKey, value: theme.textSize);
    await storage.writeInt(key: AppConst.verticalSpaceKey, value: theme.verticalSpaceSize);
    await storage.writeInt(key: AppConst.horizontallSaceKey, value: theme.horizontalSpaceSize);
    await storage.writeInt(key: AppConst.modeIndexKey, value: theme.modeIndex);
  }
}
