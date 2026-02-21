import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mq_ci_keys/mq_ci_keys.dart';
import 'package:mq_quran_client/mq_quran_client.dart';
import 'package:my_quran/modules/modules.dart';

part '../mixins/quran_book_success_widget_mixin.dart';

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

class _QuranBookSuccessWidgetState extends State<QuranBookSuccessWidget> with QuranBookSuccessWidgetMixin {
  @override
  Widget build(BuildContext context) {
    return switch (_fontStatus) {
      QuranBookFontStatus.loading => widget.sliverLoadingWidget,
      QuranBookFontStatus.success => SliverToBoxAdapter(
        child: BlocBuilder<QuranBookSettingsCubit, QuranBookSettingsState>(
          buildWhen: (p, c) => p.fontType != c.fontType,
          builder: (context, state) {
            final isBrokenPage = _brokenPages.contains(widget.data.pageNumber);
            if (state.fontType == QuranFontType.uthmanic || isBrokenPage) {
              return QuranUthmanicContent(
                widget.data,
                key: const Key(MqKeys.quranReadView),
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
          widget.data,
          key: const Key(MqKeys.quranReadView),
        ),
      ),
    };
  }
}

const _brokenPages = [
  121,
  122,
  123,
  124,
  144,
  532,
  533,
  534,
  565,
  568,
  570,
  576,
  584,
  585,
  587,
  588,
  589,
  591,
  592,
  593,
  594,
  595,
  596,
  597,
  598,
  599,
];
