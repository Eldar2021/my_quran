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
  late final PagingController<int, List<Verse>> _pagingController;
  List<int> useList = [];
  var _index = 0;

  @override
  void initState() {
    for (var i = widget.pages.first; i <= widget.pages.last; i++) {
      useList.add(i);
    }
    _pagingController = PagingController<int, List<Verse>>(
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
    return PagedListView<int, List<Verse>>(
      key: const Key('read-pages-list'),
      pagingController: _pagingController,
      physics: const BouncingScrollPhysics(),
      builderDelegate: PagedChildBuilderDelegate<List<Verse>>(
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
  const ReadQuranTextView(this.items, {super.key});

  final List<Verse> items;

  @override
  Widget build(BuildContext context) {
    // final arabcaFormat = NumberFormat.decimalPattern("ar");
    // String arabcaSayi = arabcaFormat.format(12);
    // print(arabcaSayi);
    // final texts = items.map((e) => e.textUthmani).toList();
    // var text = StringBuffer()..write(items.map((e) => '${e.textUthmani} ${e.surahNumber}'));
    // return Text(
    //   text.toString(),
    //   maxLines: 1000,
    // );
//     NumberFormat nf = NumberFormat.getInstance(Locale.forLanguageTag("AR"));
// textView.setText(String.valueOf(nf.format(285))+"\u06DD");
    return Wrap(
      alignment: WrapAlignment.end,
      spacing: 10,
      runSpacing: 10,
      children: items
          .map(
            (e) => Text(
              // '${NumberFormat.decimalPattern('ar').format(12.0)}',
              '\u06dd${e.surahNumber.toArabicDigits()}',

              locale: const Locale('ar'),
            ),
          )
          .toList(),
    );
    // return ListTile(
    //   key: Key('${item.id}-${item.verseKey}'),
    //   title: Text(item.textUthmani),
    //   leading: Text('${item.id}'),
    //   subtitle: Text(item.verseKey),
    // );
  }
}
