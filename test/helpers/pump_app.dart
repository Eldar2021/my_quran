import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hatim/app/app.dart';

extension PumpApp on WidgetTester {
  Future<void> pumpApp(AppStorageService service) {
    return pumpWidget(
      BlocProvider(
        create: (context) => AppCubit(service),
        child: const MyApp(),
      ),
    );
  }
}
