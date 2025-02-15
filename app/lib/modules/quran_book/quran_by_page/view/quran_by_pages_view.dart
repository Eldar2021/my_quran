import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mq_app_ui/mq_app_ui.dart';
import 'package:mq_quran_repository/mq_quran_repository.dart';
import 'package:my_quran/l10n/l10.dart';
import 'package:my_quran/modules/modules.dart';

class QuranByPagesView extends StatelessWidget {
  const QuranByPagesView(this.pagesNumber, {super.key});

  final List<int> pagesNumber;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (context) =>
                  QuranBookThemeCubit(readThemeRepository: context.read<ReadThemeRepository>())..initializeTheme(),
        ),
        BlocProvider(
          create:
              (context) =>
                  QuranBookByPageCubit(repository: context.read<MqQuranRepository>(), pagesNumber: pagesNumber),
        ),
      ],
      child: const _QuranByPagesView(),
    );
  }
}

class _QuranByPagesView extends StatefulWidget {
  const _QuranByPagesView();

  @override
  State<_QuranByPagesView> createState() => __QuranByPagesViewState();
}

class __QuranByPagesViewState extends State<_QuranByPagesView> {
  late final List<int> _pagesNumber;

  @override
  void initState() {
    _pagesNumber = context.read<QuranBookByPageCubit>().pagesNumber;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeCubit = context.watch<QuranBookThemeCubit>();
    return Scaffold(
      backgroundColor: themeCubit.state.bgColor,
      body: CustomScrollView(
        slivers: [
          QuranBookSliverAppBar(
            title: Text(
              context.l10n.hatim,
              maxLines: 2,
              textAlign: TextAlign.center,
              style: TextStyle(fontFamily: FontFamily.qpcUthmanicHafs, fontSize: 26, color: themeCubit.state.frColor),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(
              vertical: themeCubit.state.verticalSpaceSize,
              horizontal: themeCubit.state.horizontalSpaceSize,
            ),
            sliver: QuranByPagesPagination(_pagesNumber),
          ),
        ],
      ),
    );
  }
}
