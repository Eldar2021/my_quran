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
  bool isLoading = false;
  bool isProgressing = false;

  @override
  Widget build(BuildContext context) {
    // final colorScheme = Theme.of(context).colorScheme;
    // final prTextTheme = Theme.of(context).primaryTextTheme;
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
            isLoading: isLoading,
            isProgressing: isProgressing,
            onPressedPause: () {
              setState(() {
                isProgressing = false;
              });
            },
            onPressedPlay: () {
              setState(() {
                isProgressing = true;
              });
            },
            onDragSliderChanged: (p0) {
              setState(() {
                sliderValue = p0;
              });
            },
          ),
          const Divider(),
          QuranAudioProgressingWidget(
            sliderValue: sliderValue,
            firstTime: '00:01',
            lastTime: '10:00',
            isLoading: isLoading,
            isProgressing: isProgressing,
            onDragSliderChanged: (p0) {
              setState(() {
                sliderValue = p0;
              });
            },
            onFastForward: () {
              setState(() {
                isLoading = true;
              });
            },
            onFastRewind: () {
              setState(() {
                isLoading = false;
              });
            },
            onPressedPause: () {
              setState(() {
                isProgressing = false;
              });
            },
            onPressedPlay: () {
              setState(() {
                isProgressing = true;
              });
            },
          ),
          const Divider(),
          TextButton(
            onPressed: () {
              setState(() {
                isLoading = !isLoading;
              });
            },
            child: const Text('Set loading state'),
          ),
          const Divider(),
          const MyQuranStaticsInfoWidget(
            count1: '1200',
            count2: '9967',
            count3: '1021',
          ),
        ],
      ),
    );
  }
}
