import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mq_analytics/mq_analytics.dart';
import 'package:mq_quran_client/mq_quran_client.dart';
import 'package:my_quran/app/cubit/auth_cubit.dart';
import 'package:my_quran/l10n/l10.dart';
import 'package:my_quran/modules/modules.dart';

part '../mixins/quran_book_view_state_mixin.dart';

class QuranBookView extends StatefulWidget {
  const QuranBookView(this.args, {super.key});

  final QuranBookArgs args;

  @override
  State<QuranBookView> createState() => _QuranBookViewState();
}

class _QuranBookViewState extends State<QuranBookView> with QuranBookViewStateMixin {
  @override
  Widget build(BuildContext context) {
    return QuranBookSettingBuilder.changeThemeMode(
      builder: (context, bgColor, frColor) {
        return Scaffold(
          backgroundColor: bgColor,
          body: PageView.builder(
            controller: _pageController,
            itemCount: _pages.length,
            reverse: true,
            itemBuilder: (context, index) {
              final quranPageNumber = _pages[index];
              return BlocProvider(
                create: (context) => QuranPageCubit(
                  quranDataRepository: _quranDataRepository,
                  quranFontRepository: _quranFontRepository,
                )..loadPage(quranPageNumber, _sortSurahNumber),
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
      },
    );
  }
}
