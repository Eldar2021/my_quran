import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:my_quran/components/components.dart';
import 'package:my_quran/modules/modules.dart';
import 'package:my_quran/theme/theme.dart';

class AudioButtomSheet extends StatelessWidget {
  const AudioButtomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.colors.surfaceVariant,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(35),
          topRight: Radius.circular(35),
        ),
      ),
      child: SizedBox(
        height: 135,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text(context.watch<QuranAudioCubit>().state.surah?.name ?? '', style: context.titleMedium),
                    Text(context.watch<QuranAudioCubit>().state.surah?.arabic ?? '', style: context.titleMedium),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      iconSize: 40,
                      onPressed: context.read<QuranAudioCubit>().previousSurah,
                      icon: const Icon(Icons.skip_previous),
                    ),
                    AudioCenterButton(
                      stream: context.watch<QuranAudioCubit>().player.playerStateStream,
                      onPlay: context.read<QuranAudioCubit>().play,
                      onPause: context.read<QuranAudioCubit>().pause,
                      onReplay: () => context.read<QuranAudioCubit>().seek(0),
                    ),
                    IconButton(
                      iconSize: 40,
                      onPressed: context.read<QuranAudioCubit>().nextSurah,
                      icon: const Icon(Icons.skip_next),
                    ),
                  ],
                ),
              ],
            ),
            SeekBar(
              sliderInActiveColor: context.colors.background,
              player: context.read<QuranAudioCubit>().player,
              onChangeEnd: context.read<QuranAudioCubit>().seek,
            ),
          ],
        ),
      ),
    );
  }
}
