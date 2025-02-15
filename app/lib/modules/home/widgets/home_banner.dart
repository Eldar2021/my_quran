import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mq_app_ui/mq_app_ui.dart';
import 'package:mq_home_repository/mq_home_repository.dart';
import 'package:my_quran/app/cubit/auth_cubit.dart';
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
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: SizedBox(
          height: context.withWidth(125),
          child: CarouselView(
            itemSnapping: true,
            itemExtent: context.width - 90,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            children: banners.map((e) => HeroLayoutCard(imageUrl: _getUrl(e, context))).toList(),
          ),
        ),
      ),
    );
  }

  String _getUrl(MqHomeBannerEntity e, BuildContext context) {
    final locale = context.read<AuthCubit>().state.currentLocale.languageCode;
    return switch (locale) {
      'en' => e.imageEn,
      'ru' => e.imageRu,
      'ky' => e.imageKy,
      'tr' => e.imageTr,
      _ => e.imageEn,
    };
  }
}
