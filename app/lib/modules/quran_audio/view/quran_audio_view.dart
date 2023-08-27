import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_quran/modules/modules.dart';

class QuranAudioView extends StatelessWidget {
  const QuranAudioView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<QuranAudioCubit, QuranAudioState>(
          builder: (context, state) {
            return Text(
              '${state.surah?.name} (${state.surah?.arabic})',
            );
          },
        ),
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
              onTap: () => context.read<QuranAudioCubit>().setUrlPlay(index),
            ),
          );
        },
      ),
      bottomNavigationBar: const AudioButtomSheet(),
    );
  }
}
