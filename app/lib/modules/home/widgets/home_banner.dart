import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mq_app_ui/mq_app_ui.dart';
import 'package:mq_home_repository/mq_home_repository.dart';
import 'package:my_quran/modules/modules.dart';

class HomeBannerWidget extends StatelessWidget {
  const HomeBannerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBannersCubit, HomeBannersState>(
      builder: (context, state) {
        return switch (state) {
          HomeBannersLoaded() => _BannerWidget(state.banners),
          _ => const SizedBox.shrink(),
        };
      },
    );
  }
}

class _BannerWidget extends StatelessWidget {
  const _BannerWidget(this.banners);

  final List<MqHomeBannerEntity> banners;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: SizedBox(
        height: context.withWidth(125),
        child: CarouselView(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          itemExtent: double.infinity,
          children: banners.map((e) => BannerCard(imageUrl: e.imageEn)).toList(),
        ),
      ),
    );
  }
}
