import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mq_app_ui/mq_app_ui.dart';
import 'package:mq_quran_repository/mq_quran_repository.dart';
import 'package:my_quran/l10n/l10.dart';
import 'package:my_quran/modules/modules.dart';

class QuranByJuzView extends StatelessWidget {
  const QuranByJuzView(this.juzNumber, {super.key});

  final int juzNumber;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => QuranBookThemeCubit(
            readThemeRepository: context.read<ReadThemeRepository>(),
          )..initializeTheme(),
        ),
        BlocProvider(
          create: (context) => QuranBookByJuzCubit(
            repository: context.read<MqQuranRepository>(),
            juzNumber: juzNumber,
          ),
        ),
      ],
      child: const _QuranByJuzView(),
    );
  }
}

class _QuranByJuzView extends StatefulWidget {
  const _QuranByJuzView();

  @override
  State<_QuranByJuzView> createState() => __QuranByJuzViewState();
}

class __QuranByJuzViewState extends State<_QuranByJuzView> {
  late final int _juzNumber;
  @override
  void initState() {
    _juzNumber = context.read<QuranBookByJuzCubit>().juzNumber;
    context.read<QuranBookByJuzCubit>().getData('uthmani');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeCubit = context.watch<QuranBookThemeCubit>();
    return Scaffold(
      backgroundColor: themeCubit.state.bgColor,
      body: CustomScrollView(
        slivers: [
          QuranBookSliverAppBar(
            title: Text(
              '$_juzNumber-${context.l10n.juz}',
              maxLines: 2,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: themeCubit.state.frColor,
              ),
            ),
          ),
          BlocBuilder<QuranBookByJuzCubit, QuranBookByJuzState>(
            builder: (context, state) {
              return switch (state) {
                QuranBookByJuzInitial() => const QuranBookSliverProgressingIndicator(),
                QuranBookByJuzLoading() => const QuranBookSliverProgressingIndicator(),
                QuranBookByJuzError() => QuranBookSliverErrorWidget(state.error.toString()),
                QuranBookByJuzLoaded() => QuranBookSurahSuccessWidget(state.items),
              };
            },
          ),
          BlocBuilder<QuranBookByJuzCubit, QuranBookByJuzState>(
            builder: (context, state) {
              return switch (state) {
                QuranBookByJuzInitial() => const QuranBookSliverSizedBoxShrink(),
                QuranBookByJuzLoading() => const QuranBookSliverSizedBoxShrink(),
                QuranBookByJuzError() => const QuranBookSliverSizedBoxShrink(),
                QuranBookByJuzLoaded() => QuranBookSliverAmenButton(
                    onAmenPressed: () => Navigator.pop(context),
                    afterAmenPressed: () => Navigator.pop(context),
                  ),
              };
            },
          ),
        ],
      ),
    );
  }
}
