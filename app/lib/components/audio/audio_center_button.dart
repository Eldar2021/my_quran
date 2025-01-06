import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class AudioCenterButton extends StatelessWidget {
  const AudioCenterButton({
    required this.stream,
    required this.onPlay,
    required this.onPause,
    required this.onReplay,
    this.iconSize,
    super.key,
  });

  final Stream<PlayerState> stream;
  final VoidCallback onPlay;
  final VoidCallback onPause;
  final VoidCallback onReplay;
  final double? iconSize;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return StreamBuilder<PlayerState>(
      stream: stream,
      builder: (context, snapshot) {
        final playerState = snapshot.data;
        final processingState = playerState?.processingState;
        final playing = playerState?.playing;
        if (processingState == ProcessingState.loading || processingState == ProcessingState.buffering) {
          return IconButton(
            iconSize: 66,
            padding: EdgeInsets.zero,
            color: colorScheme.primary,
            icon: Padding(
              padding: const EdgeInsets.all(13),
              child: CupertinoActivityIndicator(
                color: colorScheme.primary,
                radius: 20,
              ),
            ),
            onPressed: null,
          );
        } else if (playing != true) {
          return IconButton(
            iconSize: 66,
            padding: EdgeInsets.zero,
            color: colorScheme.primary,
            icon: const Icon(Icons.play_circle),
            onPressed: onPlay,
          );
        } else if (processingState != ProcessingState.completed) {
          return IconButton(
            iconSize: 66,
            padding: EdgeInsets.zero,
            color: colorScheme.primary,
            icon: const Icon(Icons.pause_circle),
            onPressed: onPause,
          );
        } else {
          return IconButton(
            iconSize: 66,
            padding: EdgeInsets.zero,
            color: colorScheme.primary,
            icon: const Icon(Icons.replay),
            onPressed: onReplay,
          );
        }
      },
    );
  }
}
