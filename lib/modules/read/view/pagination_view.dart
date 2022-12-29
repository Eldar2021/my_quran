import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  List<int> useList = [];
  var _index = 0;

  @override
  void initState() {
    for (var i = widget.pages.first; i <= widget.pages.last; i++) {
      useList.add(i);
    }
    _pagingController = PagingController<int, QuranPage>(
      firstPageKey: widget.pages.first,
    );
    _pagingController.addPageRequestListener(_fetchPage);
    super.initState();
  }

  Future<void> _fetchPage(int i) async {
    try {
      final page = useList[_index];
      final newItems = await context.read<ReadCubit>().getPage(page);
      _index++;
      if (page == useList.last && newItems != null) {
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
        itemBuilder: (context, item, index) => ReadQuranTextView(item),
      ),
    );
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}

class ReadQuranTextView extends StatelessWidget {
  const ReadQuranTextView(this.item, {super.key});

  final QuranPage item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      child: Text(
        item.samePage.toString(),
        locale: const Locale('ar'),
      ),
    );
  }
}
