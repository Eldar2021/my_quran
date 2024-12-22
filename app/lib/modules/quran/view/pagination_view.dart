import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:mq_analytics/mq_analytics.dart';
import 'package:mq_ci_keys/mq_ci_keys.dart';
import 'package:mq_crashlytics/mq_crashlytics.dart';
import 'package:mq_quran_repository/mq_quran_repository.dart';
import 'package:my_quran/constants/contants.dart';
import 'package:my_quran/modules/modules.dart';
import 'package:my_quran/utils/urils.dart';
import 'package:my_quran/app/app.dart';
import 'package:my_quran/l10n/l10.dart';

class PaginationView extends StatefulWidget {
  const PaginationView(this.pages, {required this.isHatim, super.key});
  final List<int> pages;
  final bool isHatim;

  @override
  State<PaginationView> createState() => _PaginationViewState();
}

class _PaginationViewState extends State<PaginationView> {
  late final PagingController<int, QuranPageEntity> _pagingController;
  var _index = 0;

  @override
  void initState() {
    _pagingController = PagingController<int, QuranPageEntity>(
      firstPageKey: widget.pages.first,
    );
    _pagingController.addPageRequestListener(_fetchPage);
    super.initState();
  }

  Future<void> _fetchPage(int i) async {
    try {
      final page = widget.pages[_index];
      final newItems = await context.read<ReadCubit>().fetchQuranPage(page);
      _index++;
      if (page == widget.pages.last && newItems != null) {
        _pagingController.appendLastPage([newItems]);
      } else {
        final nextPageKey = page;
        _pagingController.appendPage([newItems!], nextPageKey);
      }
    } catch (e, s) {
      MqCrashlytics.report(e, s);
      _pagingController.error = e;
    }
  }

  @override
  Widget build(BuildContext context) {
    final readThemeCubit = context.watch<ReadThemeCubit>();
    return PagedSliverList<int, QuranPageEntity>.separated(
      key: const Key(MqKeys.quranReadView),
      pagingController: _pagingController,
      separatorBuilder: (context, index) => Center(
        child: Text(
          widget.pages[index].toArabicDigits,
          style: TextStyle(
            fontSize: readThemeCubit.state.textSize,
            color: ReadThemeData.frReadThemeColor[readThemeCubit.state.modeIndex],
          ),
        ),
      ),
      builderDelegate: PagedChildBuilderDelegate<QuranPageEntity>(
        itemBuilder: (context, item, index) {
          final strb = item.samePage.toString();
          final text = strb.startsWith('\n\n') ? strb.replaceFirst('\n\n', '') : strb;
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Localizations.override(
              context: context,
              locale: const Locale('ar'),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    text,
                    locale: const Locale('ar'),
                    style: TextStyle(
                      fontFamily: FontFamily.qpcUthmanicHafs,
                      fontSize: readThemeCubit.state.textSize,
                      color: ReadThemeData.frReadThemeColor[readThemeCubit.state.modeIndex],
                      height: 2.5,
                    ),
                    textDirection: TextDirection.rtl,
                  ),
                  if (widget.pages[index] == widget.pages.last)
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: ReadThemeData.frReadThemeColor[readThemeCubit.state.modeIndex],
                      ),
                      onPressed: () async {
                        MqAnalytic.track(AnalyticKey.showAmin);
                        final value = await AppAlert.showAmin<bool>(
                          context,
                          context.read<AuthCubit>().state.gender,
                          totalPages: widget.pages.length,
                          isHatim: widget.isHatim,
                        );
                        if (value != null && value && context.mounted) {
                          context.pop(true);
                        }
                      },
                      child: Text(context.l10n.readed),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}
