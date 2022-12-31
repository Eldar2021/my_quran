import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatim/locator.dart';
import 'package:hatim/modules/modules.dart';
import 'package:hatim/modules/read/logic/read_theme_cubit.dart';
import 'package:hatim/utils/urils.dart';

Map<int, Color> _bgColor = {
  1: const Color(0xffFEEDAD),
};

class ReadView extends StatelessWidget {
  const ReadView(this.pages, {super.key});

  final List<int> pages;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ReadCubit(sl<FetchPageRepo>(), pages)),
        BlocProvider(create: (context) => ReadThemeCubit()),
      ],
      child: ReadUI(pages: pages),
    );
  }
}

class ReadUI extends StatelessWidget {
  const ReadUI({super.key, required this.pages});

  final List<int> pages;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgColor[context.watch<ReadThemeCubit>().state.theme.modeIndex],
      appBar: AppBar(
        title: Text('ReadView $pages'),
        actions: [
          IconButton(
            key: const Key('read-settings-icon-view'),
            onPressed: () {
              AppBottomSheet.showBottomSheet<void>(
                context,
                (_) => BlocProvider.value(
                  value: context.read<ReadThemeCubit>(),
                  child: const ChangeReadTheme(),
                ),
              );
            },
            icon: const Icon(Icons.settings),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          vertical: context.watch<ReadThemeCubit>().state.theme.verticalSpace.toDouble(),
          horizontal: context.watch<ReadThemeCubit>().state.theme.horizontalSpace.toDouble(),
        ),
        child: PaginationView(pages),
      ),
    );
  }
}

class ChangeReadTheme extends StatelessWidget {
  const ChangeReadTheme({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Slider(
          min: 8,
          max: 40,
          value: context.watch<ReadThemeCubit>().state.theme.textSize.toDouble(),
          onChanged: (v) => context.read<ReadThemeCubit>().changeTextSize(v.toInt()),
        ),
        Slider(
          max: 140,
          value: context.watch<ReadThemeCubit>().state.theme.verticalSpace.toDouble(),
          onChanged: (v) => context.read<ReadThemeCubit>().changeVerticalSpace(v.toInt()),
        ),
        Slider(
          max: 140,
          value: context.watch<ReadThemeCubit>().state.theme.horizontalSpace.toDouble(),
          onChanged: (v) => context.read<ReadThemeCubit>().changeHorizontalSpace(v.toInt()),
        ),
      ],
    );
  }
}
