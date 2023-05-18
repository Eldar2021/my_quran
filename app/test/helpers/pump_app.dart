import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_quran/app/app.dart';
import 'package:my_quran/modules/modules.dart';

extension PumpApp on WidgetTester {
  Future<void> pumpApp(
    AppService localService,
    ThemeService themeService,
    AuthService authStorage,
    HomeService homeService,
  ) {
    return pumpWidget(
      MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => AppCubit(localService, themeService)),
          BlocProvider(create: (context) => AuthCubit(authStorage)),
          BlocProvider(create: (context) => HomeCubit(homeService)),
        ],
        child: const MyApp(),
      ),
    );
  }
}
