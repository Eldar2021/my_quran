import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class AudioCenterButton extends StatelessWidget {
  const AudioCenterButton({
    required this.stream,
    required this.onPlay,
    required this.onPause,
    required this.onReplay,
    super.key,
  });

  final Stream<PlayerState> stream;
  final VoidCallback onPlay;
  final VoidCallback onPause;
  final VoidCallback onReplay;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<PlayerState>(
      stream: stream,
      builder: (context, snapshot) {
        final playerState = snapshot.data;
        final processingState = playerState?.processingState;
        final playing = playerState?.playing;
        if (processingState == ProcessingState.loading || processingState == ProcessingState.buffering) {
          return const Padding(
            padding: EdgeInsets.all(20),
            child: SizedBox(width: 50, height: 50, child: CircularProgressIndicator()),
          );
        } else if (playing != true) {
          return IconButton(icon: const Icon(Icons.play_arrow), iconSize: 75, onPressed: onPlay);
        } else if (processingState != ProcessingState.completed) {
          return IconButton(icon: const Icon(Icons.pause), iconSize: 75, onPressed: onPause);
        } else {
          return IconButton(icon: const Icon(Icons.replay), iconSize: 75, onPressed: onReplay);
        }
      },
    );
  }
}
