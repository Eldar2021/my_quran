import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:mq_quran_client/mq_quran_client.dart';
import 'package:my_quran/modules/modules.dart';

class QuranByPageViewV3 extends StatefulWidget {
  const QuranByPageViewV3({super.key});

  static void show(BuildContext context) {
    Navigator.of(context, rootNavigator: true).push(
      MaterialPageRoute<void>(
        builder: (context) => const QuranByPageViewV3(),
      ),
    );
  }

  @override
  State<QuranByPageViewV3> createState() => _QuranByPageViewV3State();
}

class _QuranByPageViewV3State extends State<QuranByPageViewV3> {
  final PageController _pageController = PageController();
  PagingState<int, QuranPageModel> _state = PagingState();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quran'),
      ),
      body: PagedPageView<int, QuranPageModel>(
        state: _state,
        pageController: _pageController,
        fetchNextPage: fetchNextPage,
        builderDelegate: PagedChildBuilderDelegate(
          itemBuilder: (context, item, index) {
            return QuranByPageContent(item);
          },
        ),
      ),
    );
  }

  Future<void> fetchNextPage() async {
    if (_state.isLoading) return;

    setState(() {
      _state = _state.copyWith(isLoading: true, error: null);
    });

    try {
      final newKey = (_state.keys?.last ?? 0) + 1;
      final newPage = await context.read<QuranDataRepository>().getVersesByPage(newKey);
      final isLastPage = newPage.pageNumber >= 604;

      setState(() {
        _state = _state.copyWith(
          pages: [
            ...?_state.pages,
            [newPage],
          ],
          keys: [
            ...?_state.keys,
            newKey,
          ],
          hasNextPage: !isLastPage,
          isLoading: false,
        );
      });
    } on Object catch (error) {
      setState(() {
        _state = _state.copyWith(
          error: error,
          isLoading: false,
        );
      });
    }
  }
}
