import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mq_quran_client/mq_quran_client.dart';
import 'package:mq_quran_repository/mq_quran_repository.dart';

class QuranByPageContent extends StatefulWidget {
  const QuranByPageContent(this.data, {super.key});

  final QuranPageModel data;

  @override
  State<QuranByPageContent> createState() => _QuranByPageContentState();
}

class _QuranByPageContentState extends State<QuranByPageContent> {
  late final String _normalFontName;
  late final String _tajweedFontName;
  late final Future<bool> font;

  @override
  void initState() {
    _normalFontName = 'QuranByPage${widget.data.pageNumber}';
    _tajweedFontName = 'QuranByPageTajweed${widget.data.pageNumber}';
    font = _loadFont();
    super.initState();
  }

  Future<bool> _loadFont() async {
    try {
      final res = await context.read<QuranFontRepository>().getFontByPage(widget.data.pageNumber);
      final normalBytes = await res.normalFont.readAsBytes();
      final tajweedBytes = await res.tajweedFont.readAsBytes();

      final normalLoader = FontLoader(_normalFontName)
        ..addFont(
          Future.value(ByteData.view(normalBytes.buffer)),
        );

      final tajweedLoader = FontLoader(_tajweedFontName)
        ..addFont(
          Future.value(ByteData.view(tajweedBytes.buffer)),
        );

      await Future.wait([
        normalLoader.load(),
        tajweedLoader.load(),
      ]);
      return true;
    } on Object catch (e) {
      log('error: $e');
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: font,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.data ?? false) {
          return _QuranTextWithCode2(
            data: widget.data,
            fontName: _normalFontName,
            tajweedFontName: _tajweedFontName,
            isTajweed: true,
          );
        } else {
          return _QuranTextWithUthmanic(
            data: widget.data,
          );
        }
      },
    );
  }
}

class _QuranTextWithCode2 extends StatelessWidget {
  const _QuranTextWithCode2({
    required this.data,
    required this.fontName,
    required this.tajweedFontName,
    this.isTajweed = false,
  });

  final QuranPageModel data;
  final bool isTajweed;
  final String fontName;
  final String tajweedFontName;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: data.verses.map((verse) {
            return TextSpan(
              text: verse.codeV2,
              locale: const Locale('ar'),
              style: TextStyle(
                fontFamily: isTajweed ? tajweedFontName : fontName,
                fontSize: 28,
                height: 2,
              ),
              // style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              //   fontFamily: fontName,
              //   package: 'mq_quran_client',
              //   fontSize: 28,
              //   height: 2,
              //   color: Colors.black,
              // ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class _QuranTextWithUthmanic extends StatelessWidget {
  const _QuranTextWithUthmanic({
    required this.data,
  });

  final QuranPageModel data;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: data.verses.map((verse) {
            return TextSpan(
              children: [
                TextSpan(
                  text: verse.textUthmani,
                  locale: const Locale('ar'),
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontFamily: QuranFontFamily.uthmanicHafs,
                    package: 'mq_quran_client',
                    fontSize: 28,
                    height: 2.3,
                  ),
                ),
                TextSpan(
                  text: ' ${verse.ayatNumber.toArabicDigits} ',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontFamily: QuranFontFamily.uthmanicHafs,
                    package: 'mq_quran_client',
                    fontSize: 28,
                    height: 2.3,
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
