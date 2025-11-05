import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:mq_analytics/mq_analytics.dart';
import 'package:mq_app_ui/mq_app_ui.dart';
import 'package:mq_ci_keys/mq_ci_keys.dart';
import 'package:mq_quran_repository/mq_quran_repository.dart';
import 'package:my_quran/app/app.dart';
import 'package:my_quran/l10n/l10.dart';
import 'package:my_quran/modules/modules.dart';

class QuranByPagesPagination extends StatefulWidget {
  const QuranByPagesPagination({super.key});

  @override
  State<QuranByPagesPagination> createState() => _QuranByPagesPaginationState();
}

class _QuranByPagesPaginationState extends State<QuranByPagesPagination> {
  static const _quranFmt = 'uthmani';

  late final QuranPagePagingBloc _bloc;
  late final List<int> _pagesNumber;

  @override
  void initState() {
    _bloc = context.read<QuranPagePagingBloc>();
    _pagesNumber = _bloc.pagesNumber;
    super.initState();
  }

  // Future<void> _refresh() async {
  //   final event = QuranPagePagingRefresh(
  //     pageNumber: _pagesNumber[0],
  //     quranFmt: _quranFmt,
  //   );
  //   _bloc.add(event);
  // }

  void _nextPage() {
    final event = QuranPagePagingFetchNex(
      pageNumber: _pagesNumber[_bloc.state.index ?? 0],
      quranFmt: _quranFmt,
    );
    _bloc.add(event);
  }

  @override
  Widget build(BuildContext context) {
    final themeCubit = context.watch<QuranBookThemeCubit>();

    return BlocBuilder<QuranPagePagingBloc, QuranPagePagingState>(
      bloc: _bloc,
      builder: (context, state) {
        return PagedSliverList<int, QuranDataEntity>(
          key: const Key(MqKeys.quranReadView),
          state: state,
          fetchNextPage: _nextPage,
          builderDelegate: PagedChildBuilderDelegate(
            itemBuilder: (context, item, index) {
              final strb = item.dataDatePage().map((e) => e.samePage(context)).toList().toString();
              final text = strb.replaceAll('[', '').replaceAll(']', '');
              final page = int.tryParse(item.meta.filters.value);
              final isLast = index >= _pagesNumber.length - 1;

              return _QuranPageItem(
                text: text,
                themeCubit: themeCubit,
                isLast: isLast,
                page: page,
              );
            },
          ),
        );
      },
    );
  }
}

class _QuranPageItem extends StatelessWidget {
  const _QuranPageItem({
    required this.text,
    required this.themeCubit,
    required this.isLast,
    required this.page,
  });

  final String text;
  final QuranBookThemeCubit themeCubit;
  final bool isLast;
  final int? page;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Localizations.override(
        context: context,
        locale: const Locale('ar'),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              text,
              style: TextStyle(
                fontFamily: FontFamily.qpcUthmanicHafs,
                fontSize: themeCubit.state.textSize,
                color: themeCubit.state.frColor,
                height: 2.5,
              ),
              textDirection: TextDirection.rtl,
            ),
            if (page != null)
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    page!.toArabicDigits,
                    style: TextStyle(
                      fontSize: themeCubit.state.textSize,
                      color: themeCubit.state.frColor,
                    ),
                  ),
                ),
              ),
            if (isLast)
              Padding(
                padding: const EdgeInsets.only(top: 50, bottom: 50, left: 24, right: 24),
                child: ElevatedButton(
                  onPressed: () async {
                    final readThemeState = context.read<QuranBookThemeCubit>().state;
                    MqAnalytic.track(AnalyticKey.showAmin);
                    final value = await MqAlertDialogs.showAmen<bool>(
                      context: context,
                      backgroundColor: readThemeState.bgColor,
                      foregroundColor: readThemeState.frColor,
                      title: context.l10n.amen,
                      content: context.l10n.dua,
                      buttonText: context.l10n.ameen,
                      gender: context.read<AuthCubit>().state.mqAppUiGender,
                      onPressed: () => Navigator.pop(context, true),
                    );

                    if (value != null && value && context.mounted) {
                      Navigator.pop(context, true);
                    }
                  },
                  child: Text(context.l10n.readed),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
