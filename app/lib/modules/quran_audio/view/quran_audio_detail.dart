import 'package:flutter/material.dart';
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
                onPressed: () {},
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
