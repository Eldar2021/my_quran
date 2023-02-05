import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hatim/l10n/l10.dart';
import 'package:hatim/locator.dart';
import 'package:hatim/modules/modules.dart';
import 'package:hatim/modules/read/logic/read_theme_cubit.dart';
import 'package:hatim/utils/urils.dart';

const bgReadThemeColor = [
  Color(0xffFFFFFF),
  Color(0xffFFEBD0),
  Color(0xff363636),
  Color(0xff000000),
];

class ReadView extends StatelessWidget {
  const ReadView(this.pages, {super.key, required this.isHatim});

  final List<int> pages;
  final bool isHatim;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ReadCubit(sl<ReadService>(), pages)),
        BlocProvider(create: (context) => ReadThemeCubit(sl<ReadThemeService>())),
      ],
      child: ReadUI(pages: pages, isHatim: isHatim),
    );
  }
}

class ReadUI extends StatelessWidget {
  const ReadUI({
    super.key,
    required this.pages,
    required this.isHatim,
  });

  final List<int> pages;
  final bool isHatim;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgReadThemeColor[context.watch<ReadThemeCubit>().state.theme.modeIndex],
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            stretch: true,
            centerTitle: true,
            backgroundColor: bgReadThemeColor[context.watch<ReadThemeCubit>().state.theme.modeIndex],
            titleTextStyle: TextStyle(
              color: frReadThemeColor[context.watch<ReadThemeCubit>().state.theme.modeIndex],
            ),
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: FittedBox(
                child: Text(
                  'بِسْمِ ٱللَّهِ ٱلرَّحْمَـٰنِ ٱلرَّحِيمِ',
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: frReadThemeColor[context.watch<ReadThemeCubit>().state.theme.modeIndex],
                  ),
                ),
              ),
            ),
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
                icon: Icon(
                  Icons.settings,
                  color: frReadThemeColor[context.watch<ReadThemeCubit>().state.theme.modeIndex],
                ),
              )
            ],
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(
              vertical: context.watch<ReadThemeCubit>().state.theme.verticalSpace.toDouble(),
              horizontal: context.watch<ReadThemeCubit>().state.theme.horizontalSpace.toDouble(),
            ),
            sliver: PaginationView(pages, isHatim: isHatim),
          ),
        ],
      ),
    );
  }
}

class ChangeReadTheme extends StatelessWidget {
  const ChangeReadTheme({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 20),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22),
          child: Text(
            l10n.readTextSize,
            style: const TextStyle(fontSize: 18),
          ),
        ),
        Slider(
          min: 8,
          max: 40,
          value: context.watch<ReadThemeCubit>().state.theme.textSize.toDouble(),
          onChanged: (v) => context.read<ReadThemeCubit>().changeTextSize(v.toInt()),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22),
          child: Text(
            l10n.readVerticalSpace,
            style: const TextStyle(fontSize: 18),
          ),
        ),
        Slider(
          max: 140,
          value: context.watch<ReadThemeCubit>().state.theme.verticalSpace.toDouble(),
          onChanged: (v) => context.read<ReadThemeCubit>().changeVerticalSpace(v.toInt()),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22),
          child: Text(
            l10n.readHorizontallSpace,
            style: const TextStyle(fontSize: 18),
          ),
        ),
        Slider(
          max: 140,
          value: context.watch<ReadThemeCubit>().state.theme.horizontalSpace.toDouble(),
          onChanged: (v) => context.read<ReadThemeCubit>().changeHorizontalSpace(v.toInt()),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22),
          child: Text(
            l10n.readScreenMode,
            style: const TextStyle(fontSize: 18),
          ),
        ),
        const SizedBox(height: 14),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(
            bgReadThemeColor.length,
            (index) => InkWell(
              onTap: () => context.read<ReadThemeCubit>().changeMode(index),
              child: Material(
                color: bgReadThemeColor[index],
                type: MaterialType.card,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                  side: const BorderSide(),
                ),
                child: SizedBox(
                  width: 70,
                  height: 40,
                  child: Center(
                    child: Text('A', style: TextStyle(color: frReadThemeColor[index], fontSize: 22)),
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            OutlinedButton(
              onPressed: () => Navigator.pop(context),
              child: Text(l10n.cancel),
            ),
            const SizedBox(width: 10),
            OutlinedButton(
              onPressed: () async {
                await context.read<ReadThemeCubit>().saveChanges();
                // ignore: use_build_context_synchronously
                Navigator.pop(context);
              },
              child: Text(l10n.saveChanges),
            ),
            const SizedBox(width: 20),
          ],
        )
      ],
    );
  }
}
