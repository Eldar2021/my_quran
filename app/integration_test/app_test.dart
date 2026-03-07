import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:my_quran/main.dart' as app;

import 'app/hatim/hatim_test.dart';
import 'app/home/home_test.dart';
import 'app/login/login_test.dart';
import 'app/navigation.dart';
import 'app/quran_audio/quran_audio_test.dart';
import 'app/quran_read/quran_read_test.dart';
import 'app/settings/settings_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Hatim App Integration Test Flow', () {
    testWidgets('Full end-to-end user journey', (tester) async {
      // 1. App Init
      await app.main(isIntegrationTest: true);
      await tester.pumpAndSettle();

      // 2. Login Flow
      await selectLang(tester);
      await selectGender(tester);
      await loginNext(tester);
      await loginWithGoogle(tester);

      // 3. Home Flow
      await homeInit(tester);
      await goToHatimPageFromHome(tester);

      // 4. Hatim Flow
      await checkHatimJuzs(tester);
      await tapHatimJuz(tester);
      await checkHatimSelectPage(tester);
      await backPage(tester);
      await backPage(tester);

      // 5. Quran-Read Flow
      await goBottomQuranRead(tester);
      await checkQuranReadJuzs(tester);
      await checkQuranReadSurahs(tester);
      await readBaqara(tester);
      await checkQuranSettings(tester);
      await backQuranReadInitPageFromQuranReadView(tester);

      // 6. Quran-Audio Flow
      await goBottomQuranAudio(tester);
      await checkQuranAudioView(tester);
      await playFatihaAndBaqara(tester);

      // 7. Settings Flow
      await goBottomHome(tester);
      await goSettings(tester);
      await checkSettingsView(tester);
      await scrollToBottomFromMoreView(tester);
      await checkSettingsAboutUs(tester);
      await checkSettingsContactUs(tester);
      await checkSettingsTheme(tester);
    });
  });
}
