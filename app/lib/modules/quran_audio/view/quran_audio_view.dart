import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:mq_analytics/mq_analytics.dart';
import 'package:mq_ci_keys/mq_ci_keys.dart';

import 'package:my_quran/l10n/l10.dart';
import 'package:my_quran/modules/modules.dart';
import 'package:my_quran/utils/urils.dart';

class QuranAudioView extends StatelessWidget {
  const QuranAudioView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: StreamBuilder<SequenceState?>(
          stream: context.read<QuranAudioCubit>().sequenceStateStream,
          builder: (context, snapshot) {
            final index = snapshot.data?.currentIndex;
            final surah = index != null ? context.read<QuranAudioCubit>().surahs[index] : null;
            return Text('${surah?.name ?? context.l10n.audioQuran} (${surah?.arabic ?? ''})');
          },
        ),
      ),
      body: BlocListener<QuranAudioCubit, QuranAudioState>(
        listener: (context, state) {
          if (state.exception != null) {
            AppAlert.showErrorDialog(context, errorText: state.exception ?? 'Error');
          }
        },
        child: ListView.builder(
          key: const Key(MqKeys.quranAudioView),
          padding: const EdgeInsets.fromLTRB(14, 20, 14, 30),
          itemCount: context.read<QuranAudioCubit>().surahs.length,
          itemBuilder: (BuildContext context, int index) {
            final item = context.read<QuranAudioCubit>().surahs[index];
            return Card(
              child: ListTile(
                key: Key(MqKeys.quranAudioSurahIndex(index)),
                minLeadingWidth: 10,
                leading: Text('${item.id}'),
                title: Text(item.arabic),
                subtitle: Text(item.name),
                onTap: () {
                  MqAnalytic.track(
                    AnalyticKey.selectQuranAudioBySurah,
                    params: {'surahName': item.name},
                  );
                  context.read<QuranAudioCubit>().changeSurah(index);
                },
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: const AudioButtomSheet(key: Key(MqKeys.quranAudioBottomSheet)),
    );
  }
}
