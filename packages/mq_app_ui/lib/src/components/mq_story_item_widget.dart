import 'package:flutter/material.dart';
import 'package:mq_app_ui/mq_app_ui.dart';

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
class MqStoryItemsWidget extends StatelessWidget {
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
  Widget build(BuildContext context) {
    if (items.isEmpty) return const SizedBox.shrink();

    final colorScheme = Theme.of(context).colorScheme;

    return SizedBox(
      height: listHeight,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        separatorBuilder: (_, _) => SizedBox(width: buttonSpacing),
        itemBuilder: (context, index) {
          final item = items[index];
          return GestureDetector(
            onTap: () {
              MqStoryViewScreen.view(
                context,
                items: items,
                initialIndex: index,
              );
            },
            child: SizedBox(
              width: buttonWidth,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Hero(
                    tag: item.id,
                    child: Container(
                      width: buttonWidth,
                      height: buttonWidth,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: colorScheme.primary, width: 2),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(3),
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: CachedNetworkImageProvider(item.cardImageLink),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  _CardLabelText(item.cardLabel),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _CardLabelText extends StatelessWidget {
  const _CardLabelText(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    final prTextTheme = Theme.of(context).primaryTextTheme;
    final firstText = label.split('\n').first;
    final secondText = label.split('\n').last;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          firstText.isEmpty ? label : firstText,
          textAlign: TextAlign.center,
          style: prTextTheme.bodySmall,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
        if (secondText != firstText)
          Text(
            secondText,
            textAlign: TextAlign.center,
            style: prTextTheme.bodySmall,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
      ],
    );
  }
}
