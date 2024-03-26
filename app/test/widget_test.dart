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

    final homeRepo = MockHomeRepositoryImpl();
    final getLocalLocaleUseCase = GetCurrentLocaleUseCase(AppRepositoryImpl(AppLocalDataSource(storage)));
    final setLocaleUseCase = SetLocaleUseCase(AppRepositoryImpl(AppLocalDataSource(storage)));
    final getInitialThemeUseCase = GetAppInitialThemeUseCase(ThemeRepositoryImpl(ThemeLocalDataSource(storage)));
    final getInitialUserUseCase = GetInitialUserUseCase(
      AuthRepositoryImpl(
        localDataSource: AuthLocalDataSource(storage),
        remoteDataSource: AuthRemoteDataSource(client: remoteClient, storage: storage),
      ),
    );

    final loginUseCase = LoginUseCase(
      AuthRepositoryImpl(
        localDataSource: AuthLocalDataSource(storage),
        remoteDataSource: AuthRemoteDataSource(client: remoteClient, storage: storage),
      ),
    );
    final setGenderUseCase = SetGenderUseCase(
      AuthRepositoryImpl(
        localDataSource: AuthLocalDataSource(storage),
        remoteDataSource: AuthRemoteDataSource(client: remoteClient, storage: storage),
      ),
    );
    final setModeUseCase = SetModeUseCase(ThemeRepositoryImpl(ThemeLocalDataSource(storage)));
    final setColorUseCase = SetColorUseCase(ThemeRepositoryImpl(ThemeLocalDataSource(storage)));

    when(() => storage.readString(key: StorageKeys.tokenKey)).thenReturn(null);
    when(() => storage.readString(key: StorageKeys.genderKey)).thenReturn(null);
    when(() => storage.readString(key: StorageKeys.localeKey)).thenReturn('en');
    when(() => storage.readString(key: StorageKeys.modeKey)).thenReturn(null);
    when(() => storage.readString(key: StorageKeys.colorKey)).thenReturn(null);

    await tester.pumpApp(
      getLocalLocaleUseCase,
      setLocaleUseCase,
      getInitialThemeUseCase,
      setModeUseCase,
      setColorUseCase,
      getInitialUserUseCase,
      loginUseCase,
      setGenderUseCase,
      homeRepo,
    );
    await tester.pumpAndSettle();
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
