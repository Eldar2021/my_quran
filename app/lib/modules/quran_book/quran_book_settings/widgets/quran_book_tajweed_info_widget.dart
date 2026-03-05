import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mq_app_ui/mq_app_ui.dart';
import 'package:my_quran/l10n/l10.dart';
import 'package:my_quran/modules/modules.dart';

class QuranTajweedColors {
  // Silent letter (Sessiz Harf - Gri)
  static const Color silentLetter = Color(0xFF999999);

  // Normal madd (Normal Uzatma - Altın)
  static const Color normalMadd = Color(0xFFB0945A);

  // Separated madd (Ayrı Uzatma - Turuncu)
  static const Color separatedMadd = Color(0xFFD68132);

  // Connected madd (Bitişik Uzatma - Kırmızı)
  static const Color connectedMadd = Color(0xFFEE0102);

  // Necessary madd (Gerekli Uzatma - Bordo)
  static const Color necessaryMadd = Color(0xFFC50000);

  // Ghunna / Ikhfa (Gunne / İhfa - Yeşil)
  static const Color ghunnaIkhfa = Color(0xFF38794B);

  // Qalqala (Kalkale - Açık Mavi)
  static const Color qalqala = Color(0xFF22A5AD);

  // Tafkhim (Kalın Okunan - Koyu Mavi)
  static const Color tafkhim = Color(0xFF258C91);
}

class QuranBookTajweedInfoWidget extends StatelessWidget {
  const QuranBookTajweedInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final fontType = context.select<QuranBookSettingsCubit, QuranFontType>((cubit) => cubit.state.fontType);
    if (fontType != QuranFontType.tajweed) {
      return const SizedBox.shrink();
    }

    final l10n = context.l10n;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).colorScheme.primary),
        color: context.select<QuranBookSettingsCubit, Color>((c) => c.state.bgColor),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _TajweedInfoItem(color: QuranTajweedColors.silentLetter, title: l10n.silentLetter),
          const SizedBox(height: 8),
          _TajweedInfoItem(color: QuranTajweedColors.normalMadd, title: l10n.normalMadd),
          const SizedBox(height: 8),
          _TajweedInfoItem(color: QuranTajweedColors.separatedMadd, title: l10n.separatedMadd),
          const SizedBox(height: 8),
          _TajweedInfoItem(color: QuranTajweedColors.connectedMadd, title: l10n.connectedMadd),
          const SizedBox(height: 8),
          _TajweedInfoItem(color: QuranTajweedColors.necessaryMadd, title: l10n.necessaryMadd),
          const SizedBox(height: 8),
          _TajweedInfoItem(color: QuranTajweedColors.ghunnaIkhfa, title: l10n.ghunnaIkhfa),
          const SizedBox(height: 8),
          _TajweedInfoItem(color: QuranTajweedColors.qalqala, title: l10n.qalqala),
          const SizedBox(height: 8),
          _TajweedInfoItem(color: QuranTajweedColors.tafkhim, title: l10n.tafkhim),
        ],
      ),
    );
  }
}

class _TajweedInfoItem extends StatelessWidget {
  const _TajweedInfoItem({
    required this.color,
    required this.title,
  });

  final Color color;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            title,
            style: AppTextStyles.bodyMedium.copyWith(
              color: Theme.of(context).colorScheme.scrim,
            ),
          ),
        ),
      ],
    );
  }
}
