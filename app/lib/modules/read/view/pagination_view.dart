import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'package:my_quran/utils/urils.dart';
import 'package:my_quran/app/app.dart';
import 'package:my_quran/l10n/l10.dart';
import 'package:my_quran/modules/read/logic/read_theme_cubit.dart';
import 'package:my_quran/models/models.dart';
import 'package:my_quran/modules/modules.dart';

class PaginationView extends StatefulWidget {
  const PaginationView(this.pages, {required this.isHatim, super.key});
  final List<int> pages;
  final bool isHatim;

  @override
  State<PaginationView> createState() => _PaginationViewState();
}

class _PaginationViewState extends State<PaginationView> {
  late final PagingController<int, QuranPage> _pagingController;
  var _index = 0;

  @override
  void initState() {
    _pagingController = PagingController<int, QuranPage>(
      firstPageKey: widget.pages.first,
    );
    _pagingController.addPageRequestListener(_fetchPage);
    super.initState();
  }

  Future<void> _fetchPage(int i) async {
    try {
      final page = widget.pages[_index];
      final newItems = await context.read<ReadCubit>().getPage(page);
      _index++;
      if (page == widget.pages.last && newItems != null) {
        _pagingController.appendLastPage([newItems]);
      } else {
        final nextPageKey = page;
        _pagingController.appendPage([newItems!], nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return PagedSliverList<int, QuranPage>.separated(
      key: const Key('read-pages-list'),
      pagingController: _pagingController,
      separatorBuilder: (context, index) => Center(
        child: Text(
          widget.pages[index].toString(),
          style: TextStyle(
            fontSize: context.watch<ReadThemeCubit>().state.theme.textSize.toDouble(),
            color: frReadThemeColor[context.watch<ReadThemeCubit>().state.theme.modeIndex],
          ),
        ),
      ),
      builderDelegate: PagedChildBuilderDelegate<QuranPage>(
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
                    style: GoogleFonts.scheherazadeNew(
                      fontSize: context.watch<ReadThemeCubit>().state.theme.textSize.toDouble(),
                      color: frReadThemeColor[context.watch<ReadThemeCubit>().state.theme.modeIndex],
                      height: 2.5,
                    ),
                    // style: GoogleFonts.amiriQuran(
                    //   fontSize: context.watch<ReadThemeCubit>().state.theme.textSize.toDouble(),
                    //   color: frReadThemeColor[context.watch<ReadThemeCubit>().state.theme.modeIndex],
                    //   height: 3,
                    // ),
                    textDirection: TextDirection.rtl,
                  ),
                  if (widget.pages[index] == widget.pages.last)
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: frReadThemeColor[context.watch<ReadThemeCubit>().state.theme.modeIndex],
                      ),
                      onPressed: () async {
                        final value = await AppAlert.showAmin<bool>(
                          context,
                          context.read<AuthCubit>().state.user?.gender ?? Gender.male,
                          totalPages: widget.pages.length,
                          isHatim: widget.isHatim,
                        );
                        if (value != null && value && context.mounted) {
                          Navigator.of(context).pop(true);
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

const frReadThemeColor = [
  Color(0xff000000),
  Color(0xff000000),
  Color(0xffFFFFFF),
  Color(0xffFFFFFF),
];
