import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my_quran/app/app.dart';
import 'package:my_quran/config/config.dart';

extension NavigationHelper on BuildContext {
  void goNamedIfAuthenticated(
    String name, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
    Object? extra,
  }) {
    final isAuthedticated = read<AuthCubit>().isAuthedticated;
    if (isAuthedticated) {
      goNamed(name, pathParameters: pathParameters, queryParameters: queryParameters, extra: extra);
    } else {
      pushNamed(AppRouter.loginWihtSoccial);
    }
  }
}
