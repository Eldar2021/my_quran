import 'package:flutter_test/flutter_test.dart';
import 'package:hatim/app/app.dart';
import 'package:mocktail/mocktail.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'helpers/helpers.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

// flutter test

void main() {
  testWidgets('Punmp app', (WidgetTester tester) async {
    final pref = MockSharedPreferences();
    final appStorageService = AppStorageService(pref);
    final authStorage = AuthStorage(pref);

    when(() => pref.getString(authStorage.token)).thenReturn(null);
    when(() => pref.getString(authStorage.gender)).thenReturn(null);
    when(() => pref.getString(appStorageService.localStorageLocaleKey)).thenReturn('en');

    // // Build our app and trigger a frame.
    await tester.pumpApp(appStorageService, authStorage);
    await tester.pumpAndSettle();
    expect(find.text('English'), findsOneWidget);
  });
}
