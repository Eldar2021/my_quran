import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mq_quran_repository/mq_quran_repository.dart';
import 'package:my_quran/l10n/l10.dart';
import 'package:my_quran/modules/modules.dart';

class QuranBookItemView extends StatelessWidget {
  const QuranBookItemView({
    required this.pageController,
    required this.pageNumber,
    required this.startPage,
    required this.endPage,
    super.key,
  });

  final PageController pageController;
  final int pageNumber;
  final int startPage;
  final int endPage;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverAppBar(
          backgroundColor: const Color(0xffFFEED6),
          title: Text('$pageNumber-Бет $juzNumber-${context.l10n.juz}'),
          titleTextStyle: textTheme.bodyMedium,
          floating: true,
          centerTitle: false,
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.tune),
            ),
            const SizedBox(width: 16),
          ],
        ),
        BlocBuilder<QuranPageCubit, QuranPageState>(
          builder: (context, state) {
            return switch (state) {
              QuranPageInitial() || QuranPageLoading() => const QuranBookSliverAdapterLoading(),
              QuranPageError() => const QuranBookSliverAdapterErrorWidget(),
              QuranPageLoaded() => QuranBookSuccessWidgetV3(
                sliverLoadingWidget: const QuranBookSliverAdapterLoading(),
                data: state.data,
                fonts: state.fonts,
              ),
            };
          },
        ),
        SliverToBoxAdapter(
          child: QuranBookFooterWidget(
            nextButtonText: nextPage != null ? '$nextPage-Бет' : null,
            previousButtonText: previousPage != null ? '$previousPage-Бет' : null,
            onNext: nextPage != null
                ? () => pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  )
                : null,
            onPrevious: previousPage != null
                ? () {
                    pageController.previousPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  }
                : null,
            onAmeen: () {},
          ),
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: MediaQuery.of(context).padding.bottom + 16,
          ),
        ),
      ],
    );
  }

  int get juzNumber {
    for (final entry in juzPages.entries) {
      final startPage = entry.value.$1;
      final endPage = entry.value.$2;
      if (pageNumber >= startPage && pageNumber <= endPage) {
        return entry.key;
      }
    }
    return 1;
  }

  int? get nextPage {
    if (pageNumber == endPage) return null;
    return pageNumber + 1;
  }

  int? get previousPage {
    if (pageNumber == startPage) return null;
    return pageNumber - 1;
  }
}
