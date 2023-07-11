import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:my_quran/components/components.dart';
import 'package:my_quran/modules/modules.dart';
import 'package:my_quran/theme/theme.dart';

class QuranAudioDetailView extends StatefulWidget {
  const QuranAudioDetailView({super.key});

  @override
  State<QuranAudioDetailView> createState() => _QuranAudioDetailViewState();
}

class _QuranAudioDetailViewState extends State<QuranAudioDetailView> {
  @override
  void initState() {
    context.read<QuranAudioCubit>().setUrl();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final quranAudioCubit = context.watch<QuranAudioCubit>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quran Audio Detail View'),
      ),
      body: Column(
        children: [
          const Spacer(),
          Text(quranAudioCubit.state.surah?.name ?? '', style: context.displayMedium),
          Text(quranAudioCubit.state.surah?.arabic ?? '', style: context.displaySmall),
          const Spacer(flex: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                iconSize: 60,
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
                iconSize: 60,
                onPressed: () {},
                icon: const Icon(Icons.skip_next),
              ),
            ],
          ),
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
