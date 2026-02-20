part of '../view/quran_book_view.dart';

mixin QuranBookViewStateMixin on State<QuranBookView> {
  late final QuranDataRepository _quranDataRepository;
  late final QuranFontRepository _quranFontRepository;
  late final List<int> _pages;
  late final PageController _pageController;
  late final int? _sortSurahNumber;

  @override
  void initState() {
    super.initState();
    _quranDataRepository = context.read<QuranDataRepository>();
    _quranFontRepository = context.read<QuranFontRepository>();
    context.read<QuranBookSettingsCubit>().init();
    if (widget.args is QuranBySurahArgs) {
      _sortSurahNumber = (widget.args as QuranBySurahArgs).surahNumber;
    } else {
      _sortSurahNumber = null;
    }
    _pages = widget.args.pages;
    _pageController = PageController();
  }

  Future<void> _onReaded() async {
    final readThemeState = context.read<QuranBookSettingsCubit>().state;
    MqAnalytic.track(AnalyticKey.showAmin);
    await QuranAmenDialogContent.showAmen<void>(
      context: context,
      args: QuranAmenDialogContentArgs(
        readThemeState: readThemeState,
        pages: _pages,
        confirmMessage: context.l10n.confirmSurahReaded,
        gender: context.read<AuthCubit>().state.currentGender,
        hatimId: widget.args.hatimId,
        onAmen: (ctx, result) {
          Navigator.pop(ctx);
          Navigator.pop(context);
        },
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
