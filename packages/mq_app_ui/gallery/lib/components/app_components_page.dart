import 'package:flutter/material.dart';
import 'package:mq_app_ui/mq_app_ui.dart';

class AppComponentsPage extends StatefulWidget {
  const AppComponentsPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(
      builder: (_) => const AppComponentsPage(),
    );
  }

  @override
  State<AppComponentsPage> createState() => _AppComponentsPageState();
}

class _AppComponentsPageState extends State<AppComponentsPage> {
  double sliderValue = 0;

  @override
  Widget build(BuildContext context) {
    // final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('App Components'),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
        children: [
          QuranReadAudioProgressingWidget(
            sliderValue: sliderValue,
            firstTime: '00:01',
            lastTime: '10:00',
            isProgressing: true,
            onPressedPause: () {},
            onPressedPlay: () {},
            onDragSliderChanged: (p0) {
              setState(() {
                sliderValue = p0;
              });
            },
          ),
        ],
      ),
    );
  }
}
