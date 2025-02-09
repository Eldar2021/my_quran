import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:mq_analytics/mq_analytics.dart';
import 'package:mq_app_ui/mq_app_ui.dart';
import 'package:mq_ci_keys/mq_ci_keys.dart';
import 'package:mq_crashlytics/mq_crashlytics.dart';
import 'package:mq_quran_repository/mq_quran_repository.dart';
import 'package:my_quran/app/app.dart';
import 'package:my_quran/l10n/l10.dart';
import 'package:my_quran/modules/modules.dart';

class QuranByPagesPagination extends StatefulWidget {
  const QuranByPagesPagination(this.pagesNumber, {super.key});

  final List<int> pagesNumber;

  @override
  State<QuranByPagesPagination> createState() => _QuranByPagesPaginationState();
}

class _QuranByPagesPaginationState extends State<QuranByPagesPagination> {
  late final List<int> _pagesNumber;
  late final PagingController<int, QuranDataEntity> _pagingController;
  var _index = 0;

  @override
  void initState() {
    _pagesNumber = widget.pagesNumber;
    _pagingController = PagingController<int, QuranDataEntity>(
      firstPageKey: _pagesNumber.first,
    );
    _pagingController.addPageRequestListener(_fetchPage);
    super.initState();
  }

  Future<void> _fetchPage(int i) async {
    try {
      final page = _pagesNumber[_index];
      final newItems = await context.read<QuranBookByPageCubit>().getData(page, 'uthmani');
      _index++;
      if (page == _pagesNumber.last && newItems != null) {
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
    final themeCubit = context.watch<QuranBookThemeCubit>();
    return PagedSliverList<int, QuranDataEntity>.separated(
      key: const Key(MqKeys.quranReadView),
      pagingController: _pagingController,
      separatorBuilder: (context, index) => Center(
        child: Text(
          _pagesNumber[index].toArabicDigits,
          style: TextStyle(
            fontSize: themeCubit.state.textSize,
            color: themeCubit.state.frColor,
          ),
        ),
      ),
      builderDelegate: PagedChildBuilderDelegate<QuranDataEntity>(
        itemBuilder: (context, item, index) {
          final strb = item.dataDatePage().map((e) => e.samePage(context)).toList().toString();
          final text = strb.replaceAll('[', '').replaceAll(']', '');
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
                  if (_pagesNumber[index] == _pagesNumber.last)
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 50,
                        bottom: 50,
                        left: 24,
                        right: 24,
                      ),
                      child: ElevatedButton(
                        onPressed: () async {
                          final readThemeState = context.read<ReadThemeCubit>().state;
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
