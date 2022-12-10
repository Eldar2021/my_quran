import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatim/locator.dart';
import 'package:hatim/modules/modules.dart';

class ReadView extends StatelessWidget {
  const ReadView(this.pages, {super.key});

  final List<int> pages;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
