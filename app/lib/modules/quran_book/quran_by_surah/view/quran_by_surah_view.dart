import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mq_app_ui/mq_app_ui.dart';
import 'package:mq_quran_repository/mq_quran_repository.dart';
import 'package:my_quran/modules/modules.dart';

class QuranBySurahView extends StatelessWidget {
  const QuranBySurahView(this.surahNumber, {super.key});

  final int surahNumber;

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
          create: (context) => QuranBookBySurahCubit(
            repository: context.read<MqQuranRepository>(),
            surahNumber: surahNumber,
          ),
        ),
      ],
      child: const _QuranBySurahView(),
    );
  }
}

class _QuranBySurahView extends StatefulWidget {
  const _QuranBySurahView();

  @override
  State<_QuranBySurahView> createState() => __QuranBySurahViewState();
}

class __QuranBySurahViewState extends State<_QuranBySurahView> {
  late final MqSurahEntity _surahEntity;

  @override
  void initState() {
    _surahEntity = context.read<QuranBookBySurahCubit>().getSurahData();
    context.read<QuranBookBySurahCubit>().getData('uthmani');
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
              _surahEntity.nameArabic,
              maxLines: 2,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: FontFamily.uthmanicV2,
                fontSize: 32,
                color: themeCubit.state.frColor,
              ),
            ),
          ),
          BlocBuilder<QuranBookBySurahCubit, QuranBookBySurahState>(
            builder: (context, state) {
              return switch (state) {
                QuranBookBySurahInitial() => const QuranBookSliverProgressingIndicator(),
                QuranBookBySurahLoading() => const QuranBookSliverProgressingIndicator(),
                QuranBookBySurahError() => QuranBookSliverErrorWidget(
                  state.error.toString(),
                ),
                QuranBookBySurahLoaded() => QuranBookSuccessWidget(state.items),
              };
            },
          ),
          BlocBuilder<QuranBookBySurahCubit, QuranBookBySurahState>(
            builder: (context, state) {
              return switch (state) {
                QuranBookBySurahInitial() => const QuranBookSliverSizedBoxShrink(),
                QuranBookBySurahLoading() => const QuranBookSliverSizedBoxShrink(),
                QuranBookBySurahError() => const QuranBookSliverSizedBoxShrink(),
                QuranBookBySurahLoaded() => QuranBookSliverAmenButton(
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
