import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mq_app_theme/mq_app_theme.dart';
import 'package:mq_auth_repository/mq_auth_repository.dart';
import 'package:mq_home_repository/mq_home_repository.dart';

import 'helpers/helpers.dart';
import 'mocks/app_mocks.dart';

// flutter test

void main() {
  testWidgets('Punmp app', (WidgetTester tester) async {
    final packageInfo = MockPackageInfo();
    final remoteConfig = MockMqRemoteConfig();
    const appRepository = AppRepositoryImpl(
      AppLocalDataSourceMock(),
    );
    const homeRepo = MqHomeRepositoryImpl(
      MqHomeLocalDataSourceMock(),
      MqHomeRemoteDataSourceMock(),
    );
    const authRepository = AuthRepositoryImpl(
      localDataSource: AuthLocalDataSourceMock(),
      remoteDataSource: AuthRemoteDataSourceMock(),
    );

    await tester.pumpApp(
      appRepository,
      authRepository,
      homeRepo,
      remoteConfig,
      packageInfo,
    );
    await tester.pumpAndSettle();
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
