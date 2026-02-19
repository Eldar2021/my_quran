part of '../view/quran_book_success_widget.dart';

enum QuranBookFontStatus {
  loading,
  success,
  error,
}

mixin QuranBookSuccessWidgetMixin on State<QuranBookSuccessWidget> {
  late QuranBookFontStatus _fontStatus;
  late final String _normalFontFamily;
  late final String _tajweedFontFamily;

  @override
  void initState() {
    super.initState();
    _fontStatus = QuranBookFontStatus.loading;
    _normalFontFamily = 'QuranPage_${widget.data.pageNumber}';
    _tajweedFontFamily = 'QuranTajweed_${widget.data.pageNumber}';
    _initFontLoading();
  }

  Future<void> _initFontLoading() async {
    if (widget.fonts == null) {
      if (mounted) setState(() => _fontStatus = QuranBookFontStatus.error);
      return;
    }

    try {
      final (normalBytes, tajweedBytes) = await Future.wait([
        widget.fonts!.normalFont.readAsBytes(),
        widget.fonts!.tajweedFont.readAsBytes(),
      ]).then((v) => (v[0], v[1]));

      final normalLoader = FontLoader(_normalFontFamily);
      final tajweedLoader = FontLoader(_tajweedFontFamily);

      normalLoader.addFont(Future.value(ByteData.view(normalBytes.buffer)));
      tajweedLoader.addFont(Future.value(ByteData.view(tajweedBytes.buffer)));

      await Future.wait([
        normalLoader.load(),
        tajweedLoader.load(),
      ]);

      if (mounted) setState(() => _fontStatus = QuranBookFontStatus.success);
    } on Object catch (e) {
      log('FontLoader Error (Page ${widget.data.pageNumber}): $e');
      if (mounted) setState(() => _fontStatus = QuranBookFontStatus.error);
    }
  }
}
