/*
// bottomNavigationBar: DecoratedBox(
      //   decoration: BoxDecoration(
      //     gradient: LinearGradient(
      //       begin: Alignment.bottomCenter,
      //       end: Alignment.topCenter,
      //       colors: [
      //         colorScheme.primaryContainer,
      //         colorScheme.primary,
      //       ],
      //     ),
      //     borderRadius: const BorderRadius.only(
      //       topRight: Radius.circular(25),
      //       topLeft: Radius.circular(25),
      //     ),
      //   ),
      //   child: BottomNavigationBar(
      //     backgroundColor: Colors.transparent,
      //     selectedItemColor: colorScheme.onPrimary,
      //     selectedFontSize: 12,
      //     unselectedItemColor: colorScheme.onPrimary.withOpacity(0.7),
      //     onTap: context.read<MainCubit>().change,
      //     currentIndex: context.watch<MainCubit>().state,
      //     items: const [
      //       BottomNavigationBarItem(
      //         icon: Padding(
      //           padding: EdgeInsets.only(top: 12),
      //           child: Icon(Icons.book_rounded),
      //         ),
      //         label: '',
      //       ),
      //       BottomNavigationBarItem(
      //         icon: Padding(
      //           padding: EdgeInsets.only(top: 12),
      //           child: Icon(Icons.home),
      //         ),
      //         label: '',
      //       ),
      //       BottomNavigationBarItem(
      //         icon: Padding(
      //           padding: EdgeInsets.only(top: 12),
      //           child: Icon(Icons.person),
      //         ),
      //         label: '',
      //       ),
      //     ],
      //   ),
      // ),
*/
/*

class HomeCard extends StatelessWidget {
  const HomeCard({
    super.key,
    required this.titleText,
    required this.descriptioText,
    required this.valueText,
    this.verticalSpace = 15,
    this.horizontalSpace = 15,
  });

  final String titleText;
  final String descriptioText;
  final String valueText;
  final double verticalSpace;
  final double horizontalSpace;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Card(
      margin: EdgeInsets.symmetric(horizontal: horizontalSpace, vertical: verticalSpace),
      color: colorScheme.background.withOpacity(0.8),
      child: Padding(
        padding: const EdgeInsets.all(17),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              titleText,
              style: const TextStyle(fontSize: 28),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(child: Text(descriptioText)),
                const SizedBox(width: 30),
                Text(
                  valueText,
                  style: TextStyle(
                    fontSize: 42,
                    color: colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
*/
/*
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.text = 'Button',
    this.onPressed,
  });

  final String text;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            colorScheme.primary,
            colorScheme.primaryContainer,
          ],
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          fixedSize: Size(MediaQuery.of(context).size.width * 0.9, 50),
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          foregroundColor: colorScheme.onPrimary,
          textStyle: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        onPressed: onPressed,
        child: Text(text),
      ),
    );
  }
}

// Next Namaz Time Calculation

  // void _updateNextPrayerDetails() {
  //   final now = DateTime.now();
  //   final nextPrayer = _getNextPrayerDetails(now);
  //   setState(() {
  //     _nextPrayerName = nextPrayer.name;
  //     _nextPrayerTime = nextPrayer.countdown;
  //   });
  // }

  // _PrayerDetails _getNextPrayerDetails(DateTime now) {
  //   final prayerTimes = [
  //     _PrayerTime('Bagymdat', DateTime.now().copyWith(hour: 5, minute: 33)),
  //     _PrayerTime('Beshim', DateTime.now().copyWith(hour: 13, minute: 21)),
  //     _PrayerTime('Asr', DateTime.now().copyWith(hour: 17, minute: 44)),
  //     _PrayerTime('Sham', DateTime.now().copyWith(hour: 19, minute: 01)),
  //     _PrayerTime('Kuptan', DateTime.now().copyWith(hour: 21, minute: 09)),
  //   ];

  //   for (final prayerTime in prayerTimes) {
  //     if (now.isBefore(prayerTime.time)) {
  //       final duration = prayerTime.time.difference(now);
  //       return _PrayerDetails(prayerTime.name, _formatDuration(duration));
  //     }
  //   }

  //   return _PrayerDetails('Bagymdat', '');
  // }

  // String _formatDuration(Duration duration) {
  //   final hours = duration.inHours;
  //   final minutes = duration.inMinutes % 60;
  //   return '$hours h $minutes min';
  // }

*/
