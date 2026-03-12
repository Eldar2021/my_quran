import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mq_app_ui/mq_app_ui.dart';
import 'package:my_quran/core/core.dart';
import 'package:my_quran/modules/modules.dart';

class HomeStoriesWidget extends StatelessWidget {
  const HomeStoriesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MqStoryCubit, MqStoryState>(
      builder: (context, state) {
        final status = state.status;
        return switch (status) {
          FetchStatus.initial || FetchStatus.loading || FetchStatus.error => const SizedBox.shrink(),
          FetchStatus.success => MqStoryItemsWidget(
            listHeight: 130,
            buttonWidth: 70,
            buttonSpacing: 14,
            items: state.getStories.asMap().entries.map((e) {
              final idIndex = e.key;
              final item = e.value;
              return MqStoryItem(
                id: '$idIndex',
                cardImageLink: item.cardImageUrl,
                cardLabel: item.cardLabel,
                storyPagesImages: item.screens.map((e) => e.imageUrl).toList(),
                storyPageDuration: List.generate(
                  item.screens.length,
                  (index) => Duration(milliseconds: item.screens[index].durationByMilliseconds),
                ),
              );
            }).toList(),
          ),
        };
      },
    );
  }
}
