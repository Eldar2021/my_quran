import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';

import 'package:my_quran/constants/contants.dart';
// import 'package:my_quran/modules/modules.dart';
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
          Text(
            'Fatiha',
            style: context.displayMedium,
          ),
          const Spacer(flex: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                iconSize: 70,
                onPressed: () {},
                icon: const Icon(Icons.skip_previous),
              ),
              IconButton(
                iconSize: 100,
                onPressed: () async {
                  final player = AudioPlayer();
                  // final uri = ApiConst.audio(context.read<QuranAudioCubit>().state.surahIndex);
                  final uri = ApiConst.audio('001');
                  await player.setUrl(uri);
                  await player.play();
                },
                icon: const Icon(Icons.play_circle),
              ),
              IconButton(
                iconSize: 70,
                onPressed: () {},
                icon: const Icon(Icons.skip_next),
              ),
            ],
          ),
          const SizedBox(height: 40),
          Slider.adaptive(
            value: 70,
            max: 100,
            onChanged: (v) {},
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
