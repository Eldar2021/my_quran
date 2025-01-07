import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_instagram_storyboard/flutter_instagram_storyboard.dart';

@immutable
final class MqStoryItem {
  const MqStoryItem({
    required this.id,
    required this.cardImageLink,
    required this.cardLabel,
    required this.storyPagesImages,
    required this.storyPageDuration,
  });

  final String id;
  final String cardImageLink;
  final String cardLabel;
  final List<String> storyPagesImages;
  final List<Duration> storyPageDuration;
}

@immutable
class MqStoryItemsWidget extends StatefulWidget {
  const MqStoryItemsWidget({
    required this.items,
    this.listHeight = 165,
    this.buttonWidth = 100,
    this.buttonSpacing = 10,
    super.key,
  });

  final List<MqStoryItem> items;
  final double listHeight;
  final double buttonWidth;
  final double buttonSpacing;

  @override
  State<MqStoryItemsWidget> createState() => _MqStoryItemsWidgetState();
}

class _MqStoryItemsWidgetState extends State<MqStoryItemsWidget> {
  late final List<MqStoryItem> _items;
  late final StoryTimelineController _storyController;

  @override
  void initState() {
    _items = widget.items;
    _storyController = StoryTimelineController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final prTextTheme = Theme.of(context).primaryTextTheme;
    return StoryListView(
      listHeight: widget.listHeight,
      buttonWidth: widget.buttonWidth,
      buttonSpacing: widget.buttonSpacing,
      paddingLeft: 24,
      pageTransform: const StoryPage3DTransform(),
      buttonDatas: _items
          .map(
            (e) => StoryButtonData(
              storyId: e.id,
              storyController: _storyController,
              timelineBackgroundColor: colorScheme.primary,
              buttonDecoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: CachedNetworkImageProvider(e.cardImageLink),
                ),
              ),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  e.cardLabel,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  style: prTextTheme.titleSmall,
                ),
              ),
              borderDecoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: colorScheme.primary),
              ),
              storyPages: e.storyPagesImages
                  .map(
                    (i) => StoryPageScaffold(
                      body: Container(
                        width: double.infinity,
                        height: double.infinity,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: CachedNetworkImageProvider(i),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
              segmentDuration: e.storyPageDuration,
            ),
          )
          .toList(),
    );
  }
}
