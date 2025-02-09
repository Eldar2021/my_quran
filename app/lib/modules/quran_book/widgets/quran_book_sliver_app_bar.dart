import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mq_ci_keys/mq_ci_keys.dart';
import 'package:my_quran/modules/modules.dart';

class QuranBookSliverAppBar extends StatelessWidget {
  const QuranBookSliverAppBar({
    required this.title,
    super.key,
  });

  final Widget title;

  @override
  Widget build(BuildContext context) {
    final themeCubit = context.watch<QuranBookThemeCubit>();
    return SliverAppBar(
      floating: true,
      stretch: true,
      centerTitle: true,
      backgroundColor: themeCubit.state.bgColor,
      foregroundColor: themeCubit.state.frColor,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: title,
      ),
      actions: [
        IconButton(
          key: const Key(MqKeys.quranReadSettings),
          onPressed: () {},
          icon: const Icon(Icons.tune),
        ),
        const SizedBox(width: 16),
      ],
    );
  }
}
