import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_quran/theme/theme.dart';

class ContactUsView extends StatelessWidget {
  const ContactUsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.colors.primaryContainer,
        title: const Text('ContactUsView'),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(14, 20, 14, 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '\t\t\tАссалоому алейкум, урматтуу колдонуучу! Сиз колдонуп жаткан бул колдонмо боюнча суроо пайда болсо, же бул колдонмону дагы да ыңгайлуу болуусу боюнча кандайдыр бир ой-пикириңиз болсо, анда төмөнкү даректердин бирине пикириңизди жазып калтырсаңыз абдан кубанычта болобуз! \nСизди терең урматтап My Quran жамааты!\n',
              style: context.textTheme.headlineSmall,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  isSelected: true,
                  iconSize: 40,
                  onPressed: () {},
                  icon: const Icon(FontAwesomeIcons.whatsapp),
                ),
                IconButton(
                  isSelected: true,
                  iconSize: 40,
                  onPressed: () {},
                  icon: const Icon(FontAwesomeIcons.telegram),
                ),
                IconButton(
                  isSelected: true,
                  iconSize: 40,
                  onPressed: () {},
                  icon: const Icon(FontAwesomeIcons.envelopeOpen),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

// class ContactUsButtons extends StatelessWidget {
//   const ContactUsButtons({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SegmentedButton(
//       segments: const [
//         ButtonSegment(
//           value: ContactUsType.whatsapp,
//           label: Text('Day'),
//           icon: Icon(Icons.calendar_view_day),
//         ),
//         ButtonSegment(
//           value: ContactUsType.telegram,
//           label: Text('Week'),
//           icon: Icon(Icons.calendar_view_week),
//         ),
//         ButtonSegment(
//           value: ContactUsType.email,
//           label: Text('Month'),
//           icon: Icon(Icons.calendar_view_month),
//         ),
//       ],
//       selected: const <ContactUsType>{ContactUsType.email},
//       onSelectionChanged: (Set<ContactUsType> newSelection) {},
//     );
//   }
// }

// enum ContactUsType {
//   telegram,
//   whatsapp,
//   email;
// }
