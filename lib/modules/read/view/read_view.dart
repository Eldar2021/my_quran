import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatim/app/logic/app_cubit.dart';
import 'package:hatim/locator.dart';
import 'package:hatim/modules/modules.dart';

class ReadView extends StatelessWidget {
  const ReadView(this.pages, {super.key});

  final List<int> pages;

  @override
  Widget build(BuildContext context) {
    final appCubit = context.watch<AppCubit>();
    return Scaffold(
      backgroundColor: appCubit.state.theme.brightness == Brightness.light
          ? const Color.fromARGB(255, 253, 244, 223)
          : const Color(
              0xFF171D2A,
            ),
      appBar: AppBar(
        title: Text('ReadView $pages'),
      ),
      body: BlocProvider(
        create: (context) => ReadCubit(sl<FetchPageRepo>(), pages),
        child: PaginationView(pages),
      ),
    );
  }
}
