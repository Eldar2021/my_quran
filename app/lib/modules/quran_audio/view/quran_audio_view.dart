import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:mq_analytics/mq_analytics.dart';
import 'package:mq_app_ui/mq_app_ui.dart';
import 'package:mq_ci_keys/mq_ci_keys.dart';

import 'package:my_quran/l10n/l10.dart';
import 'package:my_quran/modules/modules.dart';
import 'package:my_quran/utils/urils.dart';

class QuranAudioView extends StatelessWidget {
  const QuranAudioView({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: StreamBuilder<SequenceState?>(
          stream: context.read<QuranAudioCubit>().sequenceStateStream,
          builder: (context, snapshot) {
            final index = snapshot.data?.currentIndex;
            final surah = index != null ? context.read<QuranAudioCubit>().surahs[index] : null;
            return Text('${surah?.name ?? context.l10n.listening} (${surah?.arabic ?? ''})');
          },
        ),
      ),
      body: BlocListener<QuranAudioCubit, QuranAudioState>(
        listener: (context, state) {
          if (state.exception != null) {
            AppAlert.showErrorDialog(context, errorText: state.exception ?? context.l10n.error);
          }
        },
        child: ListView.separated(
          key: const Key(MqKeys.quranAudioView),
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 30),
          itemCount: context.read<QuranAudioCubit>().surahs.length,
          itemBuilder: (BuildContext context, int index) {
            final item = context.read<QuranAudioCubit>().surahs[index];
            return QuranItemTile(
              key: Key(MqKeys.quranAudioSurahIndex(index)),
              index: item.id,
              title: item.name,
              subtitle: item.arabic,
              onTap: () {
                MqAnalytic.track(
                  AnalyticKey.selectQuranAudioBySurah,
                  params: {'surahName': item.name},
                );
                context.read<QuranAudioCubit>().changeSurah(index);
              },
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return Divider(
              height: 0.5,
              color: colorScheme.onSurface.withOpacity(0.1),
            );
          },
        ),
      ),
      bottomNavigationBar: const AudioButtomSheet(
        key: Key(MqKeys.quranAudioBottomSheet),
      ),
    );
  }
}
