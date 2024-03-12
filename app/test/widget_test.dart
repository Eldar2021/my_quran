import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mq_storage/mq_storage.dart';

import 'package:my_quran/app/app.dart';
import 'package:my_quran/constants/contants.dart';
import 'package:my_quran/core/core.dart';
import 'package:my_quran/modules/modules.dart';

import 'helpers/helpers.dart';

final class MockPreferencesStorage extends Mock implements PreferencesStorage {}

final class MockRemoteClient extends Mock implements RemoteClient {}

final class MockHomeRepositoryImpl implements HomeRepository {
  @override
  Future<HomeEntity> getData(String token) async {
    return const HomeEntity(allDoneHatims: 8, allDonePages: 5325, donePages: 634);
  }
}

// flutter test

void main() {
  testWidgets('Punmp app', (WidgetTester tester) async {
    final storage = MockPreferencesStorage();
    final remoteClient = MockRemoteClient();
    final appService = AppService(storage);
    final authStorage = AuthService(storage, remoteClient);
    final homeRepo = MockHomeRepositoryImpl();
    final themeService = ThemeService(storage);

    when(() => storage.readString(key: AppConst.tokenKey)).thenReturn(null);
    when(() => storage.readString(key: AppConst.genderKey)).thenReturn(null);
    when(() => storage.readString(key: AppConst.localeKey)).thenReturn('en');
    when(() => storage.readString(key: AppConst.modeKey)).thenReturn(null);
    when(() => storage.readString(key: AppConst.colorKey)).thenReturn(null);

    await tester.pumpApp(appService, themeService, authStorage, homeRepo);
    await tester.pumpAndSettle();
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
