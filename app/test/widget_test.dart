import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_quran/app/app.dart';
import 'package:my_quran/constants/contants.dart';

import 'helpers/helpers.dart';
import 'mocks/app_mocks.dart';

// flutter test

void main() {
  testWidgets('Punmp app', (WidgetTester tester) async {
    final storage = MockPreferencesStorage();
    final packageInfo = MockPackageInfo();
    final remoteClient = MockRemoteClient();
    final remoteConfig = MockMqRemoteConfig();
    final homeRepo = MockHomeRepositoryImpl();
    final authRepository = AuthRepositoryImpl(
      localDataSource: AuthLocalDataSourceImpl(storage),
      remoteDataSource: AuthRemoteDataSourceImpl(
        client: remoteClient,
        storage: storage,
        soccialAuth: MockSccialAuth(),
        isIntegrationTest: true,
      ),
    );

    final getInitialUserUseCase = GetInitialUserUseCase(authRepository);
    final googleSignInUseCase = GoogleSignInUseCase(authRepository);
    final appleSignInUseCase = AppleSignInUseCase(authRepository);
    final setUserDataUseCase = SerUserDataUseCase(authRepository);
    final patchLocaleCodeUseCase = PatchLocaleCodeUseCase(authRepository);
    final pathGenderUseCase = PatchGenderUseCase(authRepository);
    final logoutUseCase = LogoutUseCase(authRepository);
    final emailSignIn = EmailLoginUseCase(authRepository);
    final verifyOtp = VerifyOtpUseCase(authRepository);
    final deleteAccount = DeleteAccountUseCase(authRepository);

    when(() => storage.readString(key: StorageKeys.tokenKey)).thenReturn(null);
    when(() => storage.readString(key: StorageKeys.genderKey)).thenReturn(null);
    when(() => storage.readString(key: StorageKeys.localeKey)).thenReturn('en');
    when(() => storage.readString(key: StorageKeys.modeKey)).thenReturn(null);
    when(() => storage.readString(key: StorageKeys.colorKey)).thenReturn(null);

    await tester.pumpApp(
      getInitialUserUseCase,
      googleSignInUseCase,
      appleSignInUseCase,
      setUserDataUseCase,
      homeRepo,
      pathGenderUseCase,
      patchLocaleCodeUseCase,
      logoutUseCase,
      remoteConfig,
      packageInfo,
      emailSignIn,
      verifyOtp,
      deleteAccount,
    );
    await tester.pumpAndSettle();
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
