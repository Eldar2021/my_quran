import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mq_quran_client/mq_quran_client.dart';
import 'package:my_quran/modules/modules.dart';

class QuranBookView extends StatefulWidget {
  const QuranBookView(this.args, {super.key});

  final QuranBookArgs args;

  static void show(BuildContext context) {
    Navigator.of(context, rootNavigator: true).push(
      MaterialPageRoute<void>(
        builder: (context) => const QuranBookView(QuranByJuzArgs(114)),
      ),
    );
  }

  @override
  State<QuranBookView> createState() => _QuranBookViewState();
}

class _QuranBookViewState extends State<QuranBookView> {
  late final PageController _pageController;
  late final int? sortSurahNumber;

  @override
  void initState() {
    super.initState();
    if (widget.args is QuranBySurahArgs) {
      sortSurahNumber = (widget.args as QuranBySurahArgs).surahNumber;
    } else {
      sortSurahNumber = null;
    }
    _pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFFEED6),
      body: PageView.builder(
        controller: _pageController,
        itemCount: widget.args.pages.length,
        reverse: true,
        itemBuilder: (context, index) {
          final quranPageNumber = widget.args.pages[index];
          return BlocProvider(
            create: (context) => QuranPageCubit(
              quranDataRepository: context.read<QuranDataRepository>(),
              quranFontRepository: context.read<QuranFontRepository>(),
            )..loadPage(quranPageNumber, sortSurahNumber: sortSurahNumber),
            child: QuranBookItemView(
              pageController: _pageController,
              pageNumber: quranPageNumber,
            ),
          );
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
