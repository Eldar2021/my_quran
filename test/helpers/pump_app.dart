import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hatim/app/app.dart';
import 'package:hatim/modules/modules.dart';

extension PumpApp on WidgetTester {
  Future<void> pumpApp() {
    return pumpWidget(
      BlocProvider(
        create: (context) => SettingsCubit(),
        child: const MyApp(),
      ),
    );
  }
}
