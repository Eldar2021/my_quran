import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mq_ci_keys/mq_ci_keys.dart';
import 'package:mq_quran_client/mq_quran_client.dart';
import 'package:my_quran/l10n/l10.dart';
import 'package:my_quran/modules/modules.dart';

part '../mixins/quran_book_item_view_mixin.dart';

class QuranBookItemView extends StatefulWidget {
  const QuranBookItemView({
    required this.pageController,
    required this.pageNumber,
    required this.startPage,
    required this.endPage,
    required this.onReaded,
    super.key,
  });

  final PageController pageController;
  final void Function() onReaded;
  final int pageNumber;
  final int startPage;
  final int endPage;

  @override
  State<QuranBookItemView> createState() => _QuranBookItemViewState();
}

class _QuranBookItemViewState extends State<QuranBookItemView> with QuranBookItemViewMixin {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        QuranBookSettingBuilder.changeThemeMode(
          builder: (context, bgColor, frColor) {
            return SliverAppBar(
              backgroundColor: bgColor,
              foregroundColor: frColor,
              title: Text(_title),
              titleTextStyle: textTheme.bodyMedium?.copyWith(color: frColor),
              floating: true,
              centerTitle: false,
              actions: [
                IconButton(
                  key: const Key(MqKeys.quranReadSettings),
                  onPressed: () => QuranBookSettingsSheet.show(context),
                  icon: Icon(Icons.tune, color: frColor),
                ),
                const SizedBox(width: 16),
              ],
            );
          },
        ),
        BlocBuilder<QuranPageCubit, QuranPageState>(
          builder: (context, state) {
            return switch (state) {
              QuranPageInitial() || QuranPageLoading() => const QuranBookSliverAdapterLoading(),
              QuranPageError() => const QuranBookSliverAdapterErrorWidget(),
              QuranPageLoaded() => QuranBookSuccessWidget(
                sliverLoadingWidget: const QuranBookSliverAdapterLoading(),
                data: state.data,
                fonts: state.fonts,
              ),
            };
          },
        ),
        SliverToBoxAdapter(
          child: QuranBookFooterWidget(
            onAmeen: _onAmeen,
            nextButtonText: _nextButtonText,
            previousButtonText: _previousButtonText,
            onNext: _onNext,
            onPrevious: _onPrevious,
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
}
