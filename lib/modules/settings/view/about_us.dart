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
          Text(
            context.l10n.aboutUsDevsDesc,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }
}
