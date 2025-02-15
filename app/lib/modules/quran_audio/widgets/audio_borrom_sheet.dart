import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:mq_ci_keys/mq_ci_keys.dart';
import 'package:my_quran/components/components.dart';
import 'package:my_quran/modules/modules.dart';

class AudioButtomSheet extends StatelessWidget {
  const AudioButtomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = colorScheme.brightness == Brightness.dark;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(22), topRight: Radius.circular(22)),
        boxShadow: [BoxShadow(color: colorScheme.shadow.withValues(alpha: 0.3), blurRadius: 7)],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 20),
          SeekBar(player: context.read<QuranAudioCubit>().player, onChangeEnd: context.read<QuranAudioCubit>().seek),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              StreamBuilder<SequenceState?>(
                stream: context.read<QuranAudioCubit>().sequenceStateStream,
                builder: (context, snapshot) {
                  return IconButton(
                    iconSize: 40,
                    padding: EdgeInsets.zero,
                    icon: const Icon(Icons.fast_rewind),
                    color: isDark ? colorScheme.inverseSurface : null,
                    onPressed:
                        context.read<QuranAudioCubit>().hasPreviousSurah
                            ? () => context.read<QuranAudioCubit>().previous()
                            : null,
                  );
                },
              ),
              const SizedBox(width: 20),
              AudioCenterButton(
                key: const Key(MqKeys.quranAudioPlayPause),
                stream: context.read<QuranAudioCubit>().playerStateStream,
                onPlay: context.read<QuranAudioCubit>().play,
                onPause: context.read<QuranAudioCubit>().pause,
                onReplay: () => context.read<QuranAudioCubit>().seek(0),
                iconSize: 40,
              ),
              const SizedBox(width: 20),
              StreamBuilder<SequenceState?>(
                stream: context.read<QuranAudioCubit>().sequenceStateStream,
                builder: (context, snapshot) {
                  return IconButton(
                    iconSize: 40,
                    padding: EdgeInsets.zero,
                    icon: const Icon(Icons.fast_forward),
                    color: isDark ? colorScheme.inverseSurface : null,
                    onPressed:
                        context.read<QuranAudioCubit>().hasNextSurah
                            ? () => context.read<QuranAudioCubit>().next()
                            : null,
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
