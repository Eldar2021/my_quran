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
          const SizedBox(height: 20),
          const Divider(),
          const SizedBox(height: 20),
          MqSalaahCard(
            fajrLabel: 'Fajr',
            zuhrLabel: 'Zuhr',
            asrLabel: 'Asr',
            maghribLabel: 'Maghrib',
            ishaLabel: 'Isha',
            fajrTime: '01:00',
            zuhrTime: '02:00',
            asrTime: '03:00',
            maghribTime: '04:00',
            ishaTime: '05:00',
            fajrActive: true,
            zuhrActive: true,
            asrActive: true,
            maghribActive: false,
            ishaActive: false,
            currentTime: '17:02',
            locationLabel: 'Bishkek',
            location: 'Asia/Bishkek',
            onLocationPressed: () {},
          ),
          const SizedBox(height: 20),
          const Divider(),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CircleButton(
                backgroundColor: AppColors.tomato2,
                foregroundColor: AppColors.white,
                disabledForegroundColor: AppColors.ghostwhite,
                borderColor: AppColors.tomato2,
                child: const Text('1'),
                onPressed: () {},
              ),
              CircleButton(
                foregroundColor: AppColors.goldenrod,
                disabledForegroundColor: AppColors.goldenrod,
                borderColor: AppColors.goldenrod,
                child: const Text('2'),
                onPressed: () {},
              ),
              CircleButton(
                foregroundColor: AppColors.mediumseagreen,
                disabledForegroundColor: AppColors.mediumseagreen,
                borderColor: AppColors.mediumseagreen,
                child: const Text('3'),
                onPressed: () {},
              ),
              CircleButton(
                backgroundColor: AppColors.goldenrod,
                foregroundColor: AppColors.white,
                disabledForegroundColor: AppColors.goldenrod,
                borderColor: AppColors.goldenrod,
                child: const Text('3'),
                onPressed: () {},
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('Readed'),
              Text('In progress'),
              Text('Not Selected'),
              Text('Your selected'),
            ],
          ),
          const SizedBox(height: 20),
          const Divider(),
          const SizedBox(height: 20),
          const MqCircularChart(annotation: '20'),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ColumnInfoColoredBox(
                title: 'Readed',
                value: '9',
              ),
              ColumnInfoColoredBox(
                boxColor: AppColors.goldenrod,
                title: 'In progress',
                value: '9',
              ),
              ColumnInfoColoredBox(
                boxColor: AppColors.mediumseagreen,
                title: 'Not selected',
                value: '9',
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ColumnInfoColoredBox.circular(
                title: 'Readed',
                value: '9',
              ),
              ColumnInfoColoredBox.circular(
                boxColor: AppColors.goldenrod,
                title: 'In progress',
                value: '9',
              ),
              ColumnInfoColoredBox.circular(
                boxColor: AppColors.mediumseagreen,
                title: 'Not selected',
                value: '9',
              ),
            ],
          ),
          const SizedBox(height: 16),
          const HatimJuzItemCard(
            total: '20',
            title: 'Juz 1',
            firstText: 'Readed',
            secondText: 'In progress',
            thirdText: 'Not selected',
            firstValue: 23,
            secondValue: 5,
            thirdValue: 2,
          ),
          const SizedBox(height: 300),
        ],
      ),
    );
  }
}
