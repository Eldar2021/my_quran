import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_quran/modules/modules.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class QuranBookSliverAdapterLoading extends StatelessWidget {
  const QuranBookSliverAdapterLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const SliverToBoxAdapter(
      child: QuranBookLoadingWidget(),
    );
  }
}

class QuranBookLoadingWidget extends StatelessWidget {
  const QuranBookLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      child: BlocBuilder<QuranBookSettingsCubit, QuranBookSettingsState>(
        buildWhen: (p, c) => p.modeIndex != c.modeIndex,
        builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _shimmerLine(width * 0.45, state.loadingColor),
              _shimmerLine(width * 0.65, state.loadingColor),
              _shimmerLine(width * 0.85, state.loadingColor),
              _shimmerLine(width * 0.85, state.loadingColor),
              _shimmerLine(width * 0.75, state.loadingColor),
              _shimmerLine(width * 0.55, state.loadingColor),
              _shimmerLine(width * 0.35, state.loadingColor),
            ],
          );
        },
      ),
    );
  }

  Widget _shimmerLine(double width, Color color) {
    return Shimmer(
      colorOpacity: 1,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(16),
          ),
          child: SizedBox(
            width: width,
            height: 32,
          ),
        ),
      ),
    );
  }
}
