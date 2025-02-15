import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mq_app_ui/mq_app_ui.dart';
import 'package:mq_auth_repository/mq_auth_repository.dart';
import 'package:mq_home_repository/mq_home_repository.dart';

import 'helpers/helpers.dart';
import 'mocks/app_mocks.dart';

// flutter test

void main() {
  testWidgets('Punmp app', (WidgetTester tester) async {
    final mockRemoteConfig = MockMqRemoteConfig();
    const appRepository = AppRepositoryImpl(AppLocalDataSourceMock());
    const homeRepo = MqHomeRepositoryImpl(MqHomeLocalDataSourceMock(), MqHomeRemoteDataSourceMock());
    const authRepository = AuthRepositoryImpl(
      localDataSource: AuthLocalDataSourceMock(),
      remoteDataSource: AuthRemoteDataSourceMock(),
    );

    final storage = MockStorage();

    await tester.pumpApp(appRepository, authRepository, homeRepo, mockRemoteConfig, storage);
    await tester.pumpAndSettle();
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
