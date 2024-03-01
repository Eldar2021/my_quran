import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mq_storage/mq_storage.dart';
import 'package:my_quran/app_imports.dart';

import 'helpers/helpers.dart';

final class MockPreferencesStorage extends Mock implements PreferencesStorage {}

final class MockRemoteClient extends Mock implements RemoteClient {}

// flutter test

void main() {
  testWidgets('Punmp app', (WidgetTester tester) async {
    final storage = MockPreferencesStorage();
    final remoteClient = MockRemoteClient();
    final localDataSource = HomeLocalDataSource(storage);
    final remoteDataSource = HomeRemoteDataSource(remoteClient);

    final appService = AppService(storage);
    final authStorage = AuthService(storage, remoteClient);
    final homeService = HomeRepositoryImpl(localDataSource, remoteDataSource);
    final themeService = ThemeService(storage);

    when(() => storage.readString(key: AppConst.tokenKey)).thenReturn(null);
    when(() => storage.readString(key: AppConst.genderKey)).thenReturn(null);
    when(() => storage.readString(key: AppConst.localeKey)).thenReturn('en');
    when(() => storage.readString(key: AppConst.modeKey)).thenReturn(null);
    when(() => storage.readString(key: AppConst.colorKey)).thenReturn(null);

    // // Build our app and trigger a frame.
    await tester.pumpApp(appService, themeService, authStorage, homeService);
    await tester.pumpAndSettle();
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
