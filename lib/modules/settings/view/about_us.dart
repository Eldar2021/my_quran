import 'package:flutter/material.dart';
import 'package:hatim/l10n/l10.dart';

class AboutUsVuew extends StatelessWidget {
  const AboutUsVuew({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.aboutUs),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 20),
        children: [
          Text(
            context.l10n.aboutUs,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 20),
          const Text(
            '\t\t\t\tLorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.\n\n \t\t It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing \n\n \t\t Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }
}
