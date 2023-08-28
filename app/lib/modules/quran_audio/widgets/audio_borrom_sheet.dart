import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mq_ci_keys/mq_ci_keys.dart';

import 'package:my_quran/components/components.dart';
import 'package:my_quran/modules/modules.dart';
import 'package:my_quran/theme/theme.dart';

class AudioButtomSheet extends StatelessWidget {
  const AudioButtomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final quranAudioCubit = context.watch<QuranAudioCubit>();
    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.colors.surfaceVariant,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(35),
          topRight: Radius.circular(35),
        ),
      ),
      child: SizedBox(
        height: 112,
        child: Column(
          children: [
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  iconSize: 30,
                  onPressed: context.read<QuranAudioCubit>().previousSurah,
                  icon: const Icon(Icons.skip_previous),
                ),
                AudioCenterButton(
                  key: const Key(MqKeys.quranAudioPlayPause),
                  stream: quranAudioCubit.player.playerStateStream,
                  onPlay: context.read<QuranAudioCubit>().play,
                  onPause: context.read<QuranAudioCubit>().pause,
                  onReplay: () => context.read<QuranAudioCubit>().seek(0),
                  iconSize: 40,
                ),
                IconButton(
                  iconSize: 30,
                  onPressed: context.read<QuranAudioCubit>().nextSurah,
                  icon: const Icon(Icons.skip_next),
                ),
              ],
            ),
            SeekBar(
              sliderInActiveColor: context.colors.background,
              player: context.read<QuranAudioCubit>().player,
              onChangeEnd: context.read<QuranAudioCubit>().seek,
            ),
            const SizedBox(height: 4),
          ],
        ),
      ),
    );
  }
}
