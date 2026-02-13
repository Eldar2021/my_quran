import 'package:flutter/material.dart';
import 'package:mq_app_ui/mq_app_ui.dart';
import 'package:my_quran/modules/quran_ex/quran_ex.dart';

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
  late final QuranExModel _quranExModel;

  @override
  void initState() {
    super.initState();
    _quranExModel = QuranExModel.fromJson(exData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFFEED6),
      appBar: AppBar(
        backgroundColor: const Color(0xffFFEED6),
        title: const Text('Quran Ex'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: _quranExModel.verses.map((verse) {
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
                    // text: verse.codeV2,
                    text: codeV2,
                    locale: const Locale('ar'),
                    style: const TextStyle(
                      // fontFamily: FontFamily.normalV12,
                      fontFamily: FontFamily.tajweedV12,
                      package: 'mq_app_ui',
                      fontSize: 28,
                      height: 1.8,
                      color: Colors.black,
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      ),
      // body: PageView.builder(
      //   itemCount: 10,
      //   scrollDirection: Axis.vertical,
      //   itemBuilder: (context, index) {
      //     return SingleChildScrollView(
      //       padding: const EdgeInsets.all(20),
      //       child: Center(
      //         child: Directionality(
      //           textDirection: TextDirection.rtl,
      //           child: RichText(
      //             textAlign: TextAlign.center,
      //             text: TextSpan(
      //               children: _quranExModel.verses.map((verse) {
      //                 var codeV2 = verse.codeV2;
      //                 if (verse.id == 1) {
      //                   codeV2 = '${verse.codeV2}\n';
      //                 } else if (verse.id == 2) {
      //                   codeV2 = '${verse.codeV2}\n';
      //                 } else if (verse.id == 4) {
      //                   codeV2 = '${verse.codeV2}\n';
      //                 } else if (verse.id == 6) {
      //                   final char = verse.codeV2.characters.first;
      //                   final char2 = verse.codeV2.split(char).last;
      //                   codeV2 = '$char\n$char2';
      //                 } else if (verse.id == 7) {
      //                   final char = verse.codeV2.characters.toList();
      //                   final char1 = verse.codeV2.split(char[6]).first;
      //                   final char2 = verse.codeV2.split(char[4]).last;
      //                   final char3 = char2.split(char[14]).first;
      //                   final char4 = char2.split(char[12]).last;
      //                   codeV2 = '$char1\n$char3\n$char4';
      //                 }
      //                 return TextSpan(
      //                   text: codeV2,
      //                   locale: const Locale('ar'),
      //                   style: const TextStyle(
      //                     // fontFamily: FontFamily.page1V2,
      //                     fontFamily: FontFamily.page1Woff2,
      //                     package: 'mq_app_ui',
      //                     fontSize: 28,
      //                     height: 1.8,
      //                     color: Colors.black,
      //                   ),
      //                 );
      //               }).toList(),
      //             ),
      //           ),
      //         ),
      //       ),
      //     );
      //   },
      // ),
      // body: SingleChildScrollView(
      //   padding: const EdgeInsets.all(20),
      //   child: Center(
      //     child: Directionality(
      //       textDirection: TextDirection.rtl,
      //       child: RichText(
      //         textAlign: TextAlign.center,
      //         text: TextSpan(
      //           children: _quranExModel.verses.map((verse) {
      //             var codeV2 = verse.codeV2;
      //             if (verse.id == 1) {
      //               codeV2 = '${verse.codeV2}\n';
      //             } else if (verse.id == 2) {
      //               codeV2 = '${verse.codeV2}\n';
      //             } else if (verse.id == 4) {
      //               codeV2 = '${verse.codeV2}\n';
      //             } else if (verse.id == 6) {
      //               final char = verse.codeV2.characters.first;
      //               final char2 = verse.codeV2.split(char).last;
      //               codeV2 = '$char\n$char2';
      //             } else if (verse.id == 7) {
      //               final char = verse.codeV2.characters.toList();
      //               final char1 = verse.codeV2.split(char[6]).first;
      //               final char2 = verse.codeV2.split(char[4]).last;
      //               final char3 = char2.split(char[14]).first;
      //               final char4 = char2.split(char[12]).last;
      //               codeV2 = '$char1\n$char3\n$char4';
      //             }
      //             return TextSpan(
      //               text: codeV2,
      //               locale: const Locale('ar'),
      //               style: const TextStyle(
      //                 // fontFamily: FontFamily.page1V2,
      //                 fontFamily: FontFamily.page1Woff2,
      //                 package: 'mq_app_ui',
      //                 fontSize: 28,
      //                 height: 1.8,
      //                 color: Colors.black,
      //               ),
      //             );
      //           }).toList(),
      //         ),
      //       ),
      //     ),
      //   ),
      // ),
    );
  }
}
