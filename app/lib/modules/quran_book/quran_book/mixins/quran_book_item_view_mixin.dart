part of '../view/quran_book_item_view.dart';

mixin QuranBookItemViewMixin on State<QuranBookItemView> {
  late final int _juzNumber;
  late final bool _showAmenButton;
  late final int? _nextPage;
  late final int? _previousPage;

  @override
  void initState() {
    super.initState();
    _showAmenButton = widget.pageNumber == widget.endPage;
    _initilizeJuzNumber();
    _initializeNextPage();
    _initializePreviousPage();
  }

  void _initializePreviousPage() {
    if (widget.pageNumber == widget.startPage) _previousPage = null;
    _previousPage = widget.pageNumber - 1;
  }

  void _initializeNextPage() {
    if (widget.pageNumber == widget.endPage) _nextPage = null;
    _nextPage = widget.pageNumber + 1;
  }

  void _initilizeJuzNumber() {
    for (final entry in juzPages.entries) {
      final startPage = entry.value.$1;
      final endPage = entry.value.$2;
      if (widget.pageNumber >= startPage && widget.pageNumber <= endPage) _juzNumber = entry.key;
    }
    _juzNumber = 1;
  }

  String get _title {
    return '${widget.pageNumber}-${context.l10n.page} $_juzNumber-${context.l10n.juz}';
  }

  String? get _nextButtonText {
    return _nextPage != null ? '$_nextPage-${context.l10n.page}' : null;
  }

  String? get _previousButtonText {
    return _previousPage != null ? '$_previousPage-${context.l10n.page}' : null;
  }

  void Function()? get _onNext => _nextPage != null
      ? () => widget.pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        )
      : null;

  void Function()? get _onPrevious => _previousPage != null
      ? () {
          widget.pageController.previousPage(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        }
      : null;

  void Function()? get _onAmeen => _showAmenButton ? widget.onReaded : null;
}
