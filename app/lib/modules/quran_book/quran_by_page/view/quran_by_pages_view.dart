import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mq_app_ui/mq_app_ui.dart';
import 'package:mq_quran_repository/mq_quran_repository.dart';
import 'package:my_quran/modules/modules.dart';

class QuranByPagesView extends StatelessWidget {
  const QuranByPagesView(this.pagesNumber, {super.key});

  final List<int> pagesNumber;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => QuranBookThemeCubit(
            readThemeRepository: context.read<ReadThemeRepository>(),
          )..initializeTheme(),
        ),
        BlocProvider(
          create: (context) => QuranPagePagingBloc(
            repository: context.read<MqQuranRepository>(),
            pagesNumber: pagesNumber,
          ),
        ),
      ],
      child: const _QuranByPagesView(),
    );
  }
}

class _QuranByPagesView extends StatelessWidget {
  const _QuranByPagesView();

  @override
  Widget build(BuildContext context) {
    final themeCubit = context.watch<QuranBookThemeCubit>();
    return Scaffold(
      backgroundColor: themeCubit.state.bgColor,
      body: CustomScrollView(
        slivers: [
          QuranBookSliverAppBar(
            title: Text(
              MqQuranStatic.bismallah,
              maxLines: 2,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontFamily: FontFamily.uthmanicV2,
                color: themeCubit.state.frColor,
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(
              vertical: themeCubit.state.verticalSpaceSize,
              horizontal: themeCubit.state.horizontalSpaceSize,
            ),
            sliver: const QuranByPagesPagination(),
          ),
        ],
      ),
    );
  }
}
