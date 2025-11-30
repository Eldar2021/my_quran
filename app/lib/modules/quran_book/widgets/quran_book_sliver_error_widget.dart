import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_quran/modules/modules.dart';

class QuranBookSliverErrorWidget extends StatelessWidget {
  const QuranBookSliverErrorWidget(this.error, {super.key});

  final String error;

  @override
  Widget build(BuildContext context) {
    final themeCubit = context.watch<QuranBookThemeCubit>();
    final prTextTheme = Theme.of(context).primaryTextTheme;
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 30, 24, 30),
        child: Column(
          children: [
            Icon(
              Icons.error,
              size: 50,
              color: themeCubit.state.frColor,
            ),
            Text(
              error,
              style: prTextTheme.headlineSmall?.copyWith(
                color: themeCubit.state.frColor,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
