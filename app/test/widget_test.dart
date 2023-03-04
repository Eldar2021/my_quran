import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mq_storage/mq_storage.dart';

import 'package:my_quran/app/app.dart';
import 'package:my_quran/constants/contants.dart';
import 'package:my_quran/core/core.dart';
import 'package:my_quran/modules/home/home.dart';

import 'helpers/helpers.dart';

class MockPreferencesStorage extends Mock implements PreferencesStorage {}

class MockRemoteClient extends Mock implements RemoteClient {}

// flutter test

void main() {
  testWidgets('Punmp app', (WidgetTester tester) async {
    final storage = MockPreferencesStorage();
    final remoteClient = MockRemoteClient();

    final localService = AppService(storage);
    final authStorage = AuthService(storage, remoteClient);
    final homeService = HomeService(storage, remoteClient);
    final themeService = ThemeService(storage);

    when(() => storage.readString(key: AppConst.tokenKey)).thenReturn(null);
    when(() => storage.readString(key: AppConst.genderKey)).thenReturn(null);
    when(() => storage.readString(key: AppConst.localStorageLocaleKey)).thenReturn('en');
    when(() => storage.readString(key: AppConst.modeKey)).thenReturn(null);
    when(() => storage.readString(key: AppConst.colorKey)).thenReturn(null);

    // // Build our app and trigger a frame.
    await tester.pumpApp(localService, themeService, authStorage, homeService);
    await tester.pumpAndSettle();
    expect(find.text('English'), findsOneWidget);
  });
}
