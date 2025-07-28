import 'package:flutter/material.dart';
import 'package:mq_app_ui/mq_app_ui.dart';

const sources = [
  'https://t3.ftcdn.net/jpg/05/68/99/80/360_F_568998040_m42feFA9RajqmuR5DTlWwox44fxE3MOi.jpg',
  'https://t3.ftcdn.net/jpg/07/02/55/16/360_F_702551695_zBR0B1IrgGCJdgZbYE6dzlExKhAxD4OC.jpg',
  'https://thumbs.dreamstime.com/b/closeup-holy-quran-captured-near-sacred-kaaba-mecca-highlighting-its-spiritual-significance-ai-generated-image-329385127.jpg',
  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSaczS5PI_ePL2HwRhlEq1PPZjpLFw3PY3D5w&s',
  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS-IlJBNJLlv1cdFJ7xVWMkAjfk-mSWAJFvCu2HctMMRBRRyphoZTe0wjbkUl75fR97odM&usqp=CAU',
  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSqILNo55rnX2dLPvHPlu0Rr3_KkjM_ajDTEQ&s',
];

class StoryView extends StatefulWidget {
  const StoryView({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const StoryView());
  }

  @override
  State<StoryView> createState() => _StoryViewState();
}

class _StoryViewState extends State<StoryView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Story View')),
      body: ListView(
        children: [
          MqStoryItemsWidget(
            items: sources.asMap().entries.map((e) {
              final idx = e.key;
              final v = e.value;
              return MqStoryItem(
                id: '$idx',
                cardImageLink: v,
                cardLabel: 'New UI My Quran Team',
                storyPagesImages: sources,
                storyPageDuration: const [
                  Duration(seconds: 1),
                  Duration(seconds: 1),
                  Duration(seconds: 1),
                  Duration(seconds: 1),
                  Duration(seconds: 1),
                  Duration(seconds: 1),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
