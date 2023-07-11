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
          return const SizedBox(width: 70, height: 70, child: CircularProgressIndicator());
        } else if (playing != true) {
          return IconButton(icon: const Icon(Icons.play_arrow), iconSize: 70, onPressed: onPlay);
        } else if (processingState != ProcessingState.completed) {
          return IconButton(icon: const Icon(Icons.pause), iconSize: 70, onPressed: onPause);
        } else {
          return IconButton(icon: const Icon(Icons.replay), iconSize: 70, onPressed: onReplay);
        }
      },
    );
  }
}
