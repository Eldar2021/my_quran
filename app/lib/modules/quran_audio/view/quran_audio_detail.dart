import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:my_quran/components/components.dart';
import 'package:my_quran/modules/modules.dart';
import 'package:my_quran/theme/theme.dart';

class QuranAudioDetailView extends StatelessWidget {
  const QuranAudioDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quran Audio Detail View'),
      ),
      body: Column(
        children: [
          const Spacer(),
          Text('Fatiha', style: context.displayMedium),
          const Spacer(flex: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                iconSize: 70,
                onPressed: () {},
                icon: const Icon(Icons.skip_previous),
              ),
              AudioCenterButton(
                stream: context.watch<QuranAudioCubit>().player.playerStateStream,
                onPlay: context.read<QuranAudioCubit>().play,
                onPause: context.read<QuranAudioCubit>().pause,
                onReplay: () => context.read<QuranAudioCubit>().seek(0),
              ),
              IconButton(
                iconSize: 70,
                onPressed: () {},
                icon: const Icon(Icons.skip_next),
              ),
            ],
          ),
          const SizedBox(height: 40),
          SeekBar(
            player: context.read<QuranAudioCubit>().player,
            onChangeEnd: context.read<QuranAudioCubit>().seek,
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
