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
  late final PagingController<int, Verse> _pagingController;
  List<int> useList = [];
  var _index = 0;

  @override
  void initState() {
    for (var i = widget.pages.first; i <= widget.pages.last; i++) {
      useList.add(i);
    }
    _pagingController = PagingController<int, Verse>(
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
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = page;
        _pagingController.appendPage(newItems!, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return PagedListView<int, Verse>(
      key: const Key('read-pages-list'),
      pagingController: _pagingController,
      physics: const BouncingScrollPhysics(),
      builderDelegate: PagedChildBuilderDelegate<Verse>(
        itemBuilder: (context, item, index) => ListTile(
          key: Key('${item.id}'),
          title: Text(item.textUthmani),
          leading: Text('${item.id}'),
          subtitle: Text(item.verseKey),
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
