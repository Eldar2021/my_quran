import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mq_storage/mq_storage.dart';

import 'package:my_quran/constants/contants.dart';
import 'package:my_quran/core/core.dart';
import 'package:my_quran/l10n/l10.dart';
import 'package:my_quran/modules/modules.dart';
import 'package:my_quran/utils/urils.dart';

const bgReadThemeColor = [
  Color(0xffFFFFFF),
  Color(0xffFFEBD0),
  Color(0xff363636),
  Color(0xff000000),
];

class ReadView extends StatelessWidget {
  const ReadView(this.pages, {required this.isHatim, super.key});

  final List<int> pages;
  final bool isHatim;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ReadCubit(
            ReadService(context.read<RemoteClient>(), context.read<PreferencesStorage>()),
            pages,
          ),
        ),
        BlocProvider(create: (context) => ReadThemeCubit(ReadThemeService(context.read<PreferencesStorage>()))),
      ],
      child: ReadUI(pages: pages, isHatim: isHatim),
    );
  }
}

class ReadUI extends StatelessWidget {
  const ReadUI({
    required this.pages,
    required this.isHatim,
    super.key,
  });

  final List<int> pages;
  final bool isHatim;

  @override
  Widget build(BuildContext context) {
    final readThemeCubit = context.watch<ReadThemeCubit>();
    return Scaffold(
      backgroundColor: bgReadThemeColor[readThemeCubit.state.modeIndex],
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            stretch: true,
            centerTitle: true,
            backgroundColor: bgReadThemeColor[readThemeCubit.state.modeIndex],
            foregroundColor: frReadThemeColor[readThemeCubit.state.modeIndex],
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: FittedBox(
                child: Text(
                  AppConst.bismallah,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: FontFamily.qpcUthmanicHafs,
                    fontSize: 26,
                    color: frReadThemeColor[readThemeCubit.state.modeIndex],
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
                    (_, s) => BlocProvider.value(
                      value: context.read<ReadThemeCubit>(),
                      child: ChangeReadTheme(s),
                    ),
                  );
                },
                icon: Icon(
                  Icons.settings,
                  color: frReadThemeColor[readThemeCubit.state.modeIndex],
                ),
              ),
            ],
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(
              vertical: readThemeCubit.state.verticalSpaceSize,
              horizontal: readThemeCubit.state.horizontalSpaceSize,
            ),
            sliver: PaginationView(pages, isHatim: isHatim),
          ),
        ],
      ),
    );
  }
}

class ChangeReadTheme extends StatelessWidget {
  const ChangeReadTheme(this.controller, {super.key});
  final ScrollController controller;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final readThemeCubit = context.watch<ReadThemeCubit>();
    return ListView(
      controller: controller,
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
          value: readThemeCubit.state.textSize,
          onChanged: (v) => context.read<ReadThemeCubit>().changeTextSize(v),
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
          value: readThemeCubit.state.verticalSpaceSize,
          onChanged: (v) => context.read<ReadThemeCubit>().changeVerticalSpace(v),
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
          value: readThemeCubit.state.horizontalSpaceSize,
          onChanged: (v) => context.read<ReadThemeCubit>().changeHorizontalSpace(v),
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
                if (context.mounted) Navigator.pop(context);
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
