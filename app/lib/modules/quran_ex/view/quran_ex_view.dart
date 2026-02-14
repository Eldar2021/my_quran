import 'package:flutter/material.dart';
import 'package:mq_app_ui/mq_app_ui.dart';
import 'package:mq_quran_repository/mq_quran_repository.dart';
import 'package:my_quran/modules/quran_ex/quran_ex.dart';

enum QuranType {
  normalV12,
  tajweedV12,
  uthmanic,
}

class QuranExView extends StatefulWidget {
  const QuranExView({super.key});

  static void show(BuildContext context) {
    Navigator.of(context, rootNavigator: true).push(
      MaterialPageRoute<void>(
        builder: (context) => const QuranExView(),
      ),
    );
  }

  @override
  State<QuranExView> createState() => _QuranExViewState();
}

class _QuranExViewState extends State<QuranExView> {
  late QuranType _quranType;
  late final QuranExModel _quranExModel;

  @override
  void initState() {
    _quranType = QuranType.normalV12;
    _quranExModel = QuranExModel.fromJson(exData);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFFEED6),
      appBar: AppBar(
        backgroundColor: const Color(0xffFFEED6),
        title: Text(
          '001',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontFamily: FontFamily.surahNames,
            fontSize: 44,
            height: 2.3,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Center(
              child: switch (_quranType) {
                QuranType.uthmanic => _QuranTextWithUthmanic(
                  quranExModel: _quranExModel,
                ),
                _ => _QuranTextWithCode2(
                  quranExModel: _quranExModel,
                  isTajweed: _quranType == QuranType.tajweedV12,
                ),
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: SegmentedButton<QuranType>(
          segments: const [
            ButtonSegment<QuranType>(
              value: QuranType.normalV12,
              label: Text('Normal V1.2'),
            ),
            ButtonSegment<QuranType>(
              value: QuranType.tajweedV12,
              label: Text('Tajweed V1.2'),
            ),
            ButtonSegment<QuranType>(
              value: QuranType.uthmanic,
              label: Text('Uthmanic'),
            ),
          ],
          selected: {_quranType},
          onSelectionChanged: (type) {
            setState(() {
              _quranType = type.first;
            });
          },
        ),
      ),
    );
  }
}

class _QuranTextWithUthmanic extends StatelessWidget {
  const _QuranTextWithUthmanic({
    required this.quranExModel,
  });

  final QuranExModel quranExModel;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: quranExModel.verses.map((verse) {
            return TextSpan(
              children: [
                TextSpan(
                  text: verse.textUthmani,
                  locale: const Locale('ar'),
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontFamily: FontFamily.uthmanicHafs,
                    fontSize: 28,
                    height: 2.3,
                  ),
                ),
                TextSpan(
                  text: ' ${verse.ayatNumber.toArabicDigits} ',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontFamily: FontFamily.uthmanicRegular,
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

class _QuranTextWithCode2 extends StatelessWidget {
  const _QuranTextWithCode2({
    required this.quranExModel,
    this.isTajweed = false,
  });

  final QuranExModel quranExModel;
  final bool isTajweed;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: quranExModel.verses.map((verse) {
            var codeV2 = verse.codeV2;
            if (verse.id == 1) {
              codeV2 = '${verse.codeV2}\n';
            } else if (verse.id == 2) {
              codeV2 = '${verse.codeV2}\n';
            } else if (verse.id == 4) {
              codeV2 = '${verse.codeV2}\n';
            } else if (verse.id == 6) {
              final char = verse.codeV2.characters.first;
              final char2 = verse.codeV2.split(char).last;
              codeV2 = '$char\n$char2';
            } else if (verse.id == 7) {
              final char = verse.codeV2.characters.toList();
              final char1 = verse.codeV2.split(char[6]).first;
              final char2 = verse.codeV2.split(char[4]).last;
              final char3 = char2.split(char[14]).first;
              final char4 = char2.split(char[12]).last;
              codeV2 = '$char1\n$char3\n$char4';
            }
            return TextSpan(
              text: codeV2,
              locale: const Locale('ar'),
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontFamily: isTajweed ? FontFamily.tajweedV12 : FontFamily.normalV12,
                package: 'mq_app_ui',
                fontSize: 28,
                height: 2,
                color: Colors.black,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
