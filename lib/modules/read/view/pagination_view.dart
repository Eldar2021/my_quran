import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatim/modules/read/logic/read_theme_cubit.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'package:hatim/models/models.dart';
import 'package:hatim/modules/modules.dart';

class PaginationView extends StatefulWidget {
  const PaginationView(this.pages, {super.key});
  final List<int> pages;

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
    return PagedListView<int, QuranPage>(
      key: const Key('read-pages-list'),
      pagingController: _pagingController,
      physics: const BouncingScrollPhysics(),
      builderDelegate: PagedChildBuilderDelegate<QuranPage>(
        itemBuilder: (context, item, index) => Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                item.samePage.toString(),
                locale: const Locale('ar'),
                style: TextStyle(
                  fontSize: context.watch<ReadThemeCubit>().state.theme.textSize.toDouble(),
                  color: frReadThemeColor[context.watch<ReadThemeCubit>().state.theme.modeIndex],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  widget.pages[index].toString(),
                  style: TextStyle(
                    fontSize: context.watch<ReadThemeCubit>().state.theme.textSize.toDouble(),
                    color: frReadThemeColor[context.watch<ReadThemeCubit>().state.theme.modeIndex],
                  ),
                ),
              ],
            )
          ],
        ),
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
