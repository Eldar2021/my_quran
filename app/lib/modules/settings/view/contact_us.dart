import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_quran/core/core.dart';
import 'package:my_quran/l10n/l10.dart';
import 'package:my_quran/theme/theme.dart';
import 'package:my_quran/components/card/contact_us_card.dart';

class ContactUsView extends StatelessWidget {
  const ContactUsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.colors.primaryContainer,
        title: Text(
          context.l10n.contactUs,
          style: context.textTheme.headlineMedium!.copyWith(color: context.colors.onPrimaryContainer),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(14, 20, 14, 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const ContactUsCard(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  isSelected: true,
                  iconSize: 40,
                  onPressed: () async => AppLaunch.sendWhatsApp(
                    '996990039301',
                    snackBarText: context.l10n.feedBackSms,
                    context: context,
                  ),
                  icon: const Icon(FontAwesomeIcons.whatsapp),
                ),
                IconButton(
                  isSelected: true,
                  iconSize: 40,
                  onPressed: () async => AppLaunch.sendTelegram(
                    'ak_bulak',
                    snackBarText: context.l10n.feedBackSms,
                    context: context,
                  ),
                  icon: const Icon(FontAwesomeIcons.telegram),
                ),
                IconButton(
                  isSelected: true,
                  iconSize: 40,
                  onPressed: () async => AppLaunch.sendEmail(
                    'eldiiaralmazbekov@gmail.com',
                    snackBarText: context.l10n.feedBackSms,
                    context: context,
                  ),
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
