import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_quran/modules/modules.dart';

class WillPopScopeWidget extends StatelessWidget {
  const WillPopScopeWidget({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final mainCubit = context.watch<MainCubit>();
    return WillPopScope(
      onWillPop: () async {
        mainCubit.change(1);
        return false;
      },
      child: child,
    );
  }
}
