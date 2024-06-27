import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mq_storage/mq_storage.dart';
import 'package:my_quran/app/app.dart';
import 'package:my_quran/constants/contants.dart';
import 'package:my_quran/core/core.dart';
import 'package:my_quran/modules/modules.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'helpers/helpers.dart';

final class MockPreferencesStorage extends Mock implements PreferencesStorage {}

final class MockRemoteClient extends Mock implements RemoteClient {}

final class MockSccialAuth extends Mock implements SoccialAuth {}

final class MockPackageInfo extends Mock implements PackageInfo {
  @override
  String get version => '1.3.0';
}

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
    final packageInfo = MockPackageInfo();
    final remoteClient = MockRemoteClient();

    final homeRepo = MockHomeRepositoryImpl();
    final appLocalDataSource = AppLocalDataSource(packageInfo: packageInfo);
    final appRepository = AppRepositoryImpl(appLocalDataSource);
    final themeRepository = ThemeRepositoryImpl(ThemeLocalDataSource(storage));
    final authRepository = AuthRepositoryImpl(
      localDataSource: AuthLocalDataSource(storage),
      remoteDataSource: AuthRemoteDataSource(
        client: remoteClient,
        storage: storage,
        soccialAuth: MockSccialAuth(),
        isIntegrationTest: true,
      ),
    );

    final getInitialThemeUseCase = GetAppInitialThemeUseCase(themeRepository);
    final getInitialUserUseCase = GetInitialUserUseCase(authRepository);

    final googleSignInUseCase = GoogleSignInUseCase(authRepository);
    final appleSignInUseCase = AppleSignInUseCase(authRepository);
    final setUserDataUseCase = SerUserDataUseCase(authRepository);
    final patchLocaleCodeUseCase = PatchLocaleCodeUseCase(authRepository);
    final pathGenderUseCase = PatchGenderUseCase(authRepository);
    final setModeUseCase = SetModeUseCase(themeRepository);
    final setColorUseCase = SetColorUseCase(themeRepository);
    final getAppVersionUseCase = GetAppVersionUseCase(appRepository);

    when(() => storage.readString(key: StorageKeys.tokenKey)).thenReturn(null);
    when(() => storage.readString(key: StorageKeys.genderKey)).thenReturn(null);
    when(() => storage.readString(key: StorageKeys.localeKey)).thenReturn('en');
    when(() => storage.readString(key: StorageKeys.modeKey)).thenReturn(null);
    when(() => storage.readString(key: StorageKeys.colorKey)).thenReturn(null);

    await tester.pumpApp(
      getInitialThemeUseCase,
      setModeUseCase,
      setColorUseCase,
      getInitialUserUseCase,
      getAppVersionUseCase,
      googleSignInUseCase,
      appleSignInUseCase,
      setUserDataUseCase,
      homeRepo,
      pathGenderUseCase,
      patchLocaleCodeUseCase,
      storage,
    );
    await tester.pumpAndSettle();
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
