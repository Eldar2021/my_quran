import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mq_ci_keys/mq_ci_keys.dart';
import 'package:mq_quran_client/mq_quran_client.dart';
import 'package:my_quran/modules/modules.dart';

enum QuranBookFontStatus {
  loading,
  success,
  error,
}

class QuranBookSuccessWidget extends StatefulWidget {
  const QuranBookSuccessWidget({
    required this.sliverLoadingWidget,
    required this.data,
    this.fonts,
    super.key,
  });

  final Widget sliverLoadingWidget;
  final QuranPageModel data;
  final QuranFontModel? fonts;

  @override
  State<QuranBookSuccessWidget> createState() => _QuranBookSuccessWidgetState();
}

class _QuranBookSuccessWidgetState extends State<QuranBookSuccessWidget> {
  late QuranBookFontStatus _fontStatus;
  late final String _normalFontFamily;
  late final String _tajweedFontFamily;

  @override
  void initState() {
    _fontStatus = QuranBookFontStatus.loading;
    super.initState();
    _normalFontFamily = 'QuranPage_${widget.data.pageNumber}';
    _tajweedFontFamily = 'QuranTajweed_${widget.data.pageNumber}';
    _initFontLoading();
  }

  @override
  Widget build(BuildContext context) {
    return switch (_fontStatus) {
      QuranBookFontStatus.loading => widget.sliverLoadingWidget,
      QuranBookFontStatus.success => SliverToBoxAdapter(
        child: BlocBuilder<QuranBookSettingsCubit, QuranBookSettingsState>(
          buildWhen: (p, c) => p.fontType != c.fontType,
          builder: (context, state) {
            if (state.fontType == QuranFontType.uthmanic) {
              return QuranUthmanicContent(
                key: const Key(MqKeys.quranReadView),
                data: widget.data,
              );
            }
            return QuranCodeV2Content(
              key: const Key(MqKeys.quranReadView),
              data: widget.data,
              fontFamily: switch (state.fontType) {
                QuranFontType.tajweed => _tajweedFontFamily,
                _ => _normalFontFamily,
              },
            );
          },
        ),
      ),
      QuranBookFontStatus.error => SliverToBoxAdapter(
        child: QuranUthmanicContent(
          key: const Key(MqKeys.quranReadView),
          data: widget.data,
        ),
      ),
    };
  }

  Future<void> _initFontLoading() async {
    if (widget.fonts == null) {
      if (mounted) setState(() => _fontStatus = QuranBookFontStatus.error);
      return;
    }

    try {
      final normalBytes = await widget.fonts!.normalFont.readAsBytes();
      final tajweedBytes = await widget.fonts!.tajweedFont.readAsBytes();
      final normalLoader = FontLoader(_normalFontFamily)..addFont(Future.value(ByteData.view(normalBytes.buffer)));
      final tajweedLoader = FontLoader(_tajweedFontFamily)..addFont(Future.value(ByteData.view(tajweedBytes.buffer)));

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
