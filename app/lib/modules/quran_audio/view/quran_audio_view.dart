import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:my_quran/modules/modules.dart';

class QuranAudioView extends StatelessWidget {
  const QuranAudioView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Quran Audio View'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.fromLTRB(14, 20, 14, 30),
        itemCount: context.read<QuranAudioCubit>().surahs.length,
        itemBuilder: (BuildContext context, int index) {
          final item = context.read<QuranAudioCubit>().surahs[index];
          return Card(
            child: ListTile(
              key: Key('quran-audio-${item.id}-surah'),
              minLeadingWidth: 10,
              leading: Text('${item.id}'),
              title: Text(item.arabic),
              subtitle: Text(item.name),
              onTap: () {
                context.read<QuranAudioCubit>().changeSurah(index);
                Navigator.push<void>(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => const QuranAudioDetailView(),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
