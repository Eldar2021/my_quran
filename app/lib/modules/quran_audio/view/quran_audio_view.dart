import 'package:flutter/material.dart';
import 'package:my_quran/models/models.dart';

class QuranAudioView extends StatefulWidget {
  const QuranAudioView({super.key});

  @override
  State<QuranAudioView> createState() => _QuranAudioViewState();
}

class _QuranAudioViewState extends State<QuranAudioView> {
  final surahs = surahData.map(Surah.fromJson).toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Quran Audio View'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.fromLTRB(14, 20, 14, 30),
        itemCount: surahs.length,
        itemBuilder: (BuildContext context, int index) {
          final item = surahs[index];
          return Card(
            child: ListTile(
              key: Key('quran-audio-${item.id}-surah'),
              minLeadingWidth: 10,
              leading: Text('${item.id}'),
              title: Text(item.arabic),
              subtitle: Text(item.name),
              onTap: () async {},
            ),
          );
        },
      ),
    );
  }
}
