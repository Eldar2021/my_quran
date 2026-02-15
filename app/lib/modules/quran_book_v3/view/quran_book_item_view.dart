import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_quran/modules/modules.dart';

class QuranBookItemView extends StatelessWidget {
  const QuranBookItemView({
    required this.pageController,
    required this.pageNumber,
    super.key,
  });

  final PageController pageController;
  final int pageNumber;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverAppBar(
          backgroundColor: const Color(0xffFFEED6),
          title: Text('$pageNumber'),
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
      ],
    );
  }
}
