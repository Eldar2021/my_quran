import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hatim/app/app.dart';

extension PumpApp on WidgetTester {
  Future<void> pumpApp(AppService localService, ThemeService themeService, AuthService authStorage) {
    return pumpWidget(
      MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => AppCubit(localService, themeService)),
          BlocProvider(create: (context) => AuthCubit(authStorage)),
        ],
        child: const MyApp(),
      ),
    );
  }
}
