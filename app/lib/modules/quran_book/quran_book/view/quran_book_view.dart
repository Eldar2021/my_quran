import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mq_analytics/mq_analytics.dart';
import 'package:mq_quran_client/mq_quran_client.dart';
import 'package:my_quran/app/cubit/auth_cubit.dart';
import 'package:my_quran/l10n/l10.dart';
import 'package:my_quran/modules/modules.dart';

class QuranBookView extends StatefulWidget {
  const QuranBookView(this.args, {super.key});

  final QuranBookArgs args;

  @override
  State<QuranBookView> createState() => _QuranBookViewState();
}

class _QuranBookViewState extends State<QuranBookView> {
  late final List<int> _pages;
  late final PageController _pageController;
  late final int? sortSurahNumber;

  @override
  void initState() {
    super.initState();
    context.read<QuranBookSettingsCubit>().init();
    _pages = widget.args.pages;
    if (widget.args is QuranBySurahArgs) {
      sortSurahNumber = (widget.args as QuranBySurahArgs).surahNumber;
    } else {
      sortSurahNumber = null;
    }
    _pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    final themeCubit = context.watch<QuranBookSettingsCubit>();
    return Scaffold(
      backgroundColor: themeCubit.state.bgColor,
      body: PageView.builder(
        controller: _pageController,
        itemCount: _pages.length,
        reverse: true,
        itemBuilder: (context, index) {
          final quranPageNumber = _pages[index];
          return BlocProvider(
            create: (context) => QuranPageCubit(
              quranDataRepository: context.read<QuranDataRepository>(),
              quranFontRepository: context.read<QuranFontRepository>(),
            )..loadPage(quranPageNumber, sortSurahNumber: sortSurahNumber),
            child: QuranBookItemView(
              pageController: _pageController,
              pageNumber: quranPageNumber,
              startPage: _pages.first,
              endPage: _pages.last,
              onReaded: _onReaded,
            ),
          );
        },
      ),
    );
  }

  Future<void> _onReaded() async {
    final readThemeState = context.read<QuranBookSettingsCubit>().state;
    MqAnalytic.track(AnalyticKey.showAmin);
    await QuranAmenDialogContent.showAmen<void>(
      context: context,
      args: QuranAmenDialogContentArgs(
        readThemeState: readThemeState,
        pages: _pages,
        confirmMessage: context.l10n.confirmSurahReaded,
        gender: context.read<AuthCubit>().state.currentGender,
        hatimId: widget.args.hatimId,
        onAmen: (ctx, result) {
          Navigator.pop(ctx);
          Navigator.pop(context);
        },
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
