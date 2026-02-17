import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mq_quran_client/mq_quran_client.dart';
import 'package:collection/collection.dart';
import 'package:my_quran/modules/modules.dart';

class QuranCodeV2Content extends StatelessWidget {
  const QuranCodeV2Content({
    required this.data,
    required this.fontFamily,
    required this.tajweedFontFamily,
    super.key,
  });

  final QuranPageModel data;
  final String fontFamily;
  final String tajweedFontFamily;

  @override
  Widget build(BuildContext context) {
    final themeCubit = context.watch<QuranBookSettingsCubit>();
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: themeCubit.state.horizontalSpaceSize,
        vertical: themeCubit.state.verticalSpaceSize,
      ),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: RichText(
          textAlign: TextAlign.center,
          textHeightBehavior: const TextHeightBehavior(),
          text: TextSpan(
            style: _getStyle(
              tajweedFontFamily,
              themeCubit.state.frColor,
              themeCubit.state.textSize,
            ),
            children: data.verses.mapIndexed((index, verse) {
              return TextSpan(
                children: [
                  if (verse.isFirstAyat)
                    WidgetSpan(
                      child: SizedBox(
                        width: double.infinity,
                        child: Column(
                          children: [
                            if (index != 0) const Divider(),
                            Center(
                              child: Text(
                                verse.chapterId.toString().padLeft(3, '0'),
                                style:
                                    _getStyle(
                                      QuranFontFamily.surahNames,
                                      themeCubit.state.frColor,
                                      themeCubit.state.textSize,
                                    ).copyWith(
                                      package: 'mq_quran_client',
                                      fontSize: themeCubit.state.textSize + 16,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  if (verse.showBismillah) ...[
                    WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: SizedBox(
                        height: themeCubit.state.textSize + 12,
                        width: double.infinity,
                        child: QuranAssets.icons.bismillah.svg(
                          width: double.infinity,
                          colorFilter: ColorFilter.mode(themeCubit.state.frColor, BlendMode.srcIn),
                        ),
                      ),
                    ),
                  ],
                  TextSpan(text: verse.formattedCode2),
                ],
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  TextStyle _getStyle(String fontFamily, Color color, double fontSize) {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: switch (data.pageNumber) {
        1 || 2 => 28,
        _ => fontSize,
      },
      color: color,
      height: 2.2,
    );
  }
}
