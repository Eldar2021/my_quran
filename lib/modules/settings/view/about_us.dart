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
            '\t\t\t\t"Пайгамбарыбыз Мухаммед Мустафа (сав) бизге калтырган эң чон аманат бул Куран. Мусулмандар бир өрөөндө, Куран башка бир өрөөндө калган азыркы доордо бардык дин бир туугандарыбызды куттуу Курандын кереметтүү дүйнөсүнө чакырууну туура көрдүк.\t\t \n\n Улутуңуз, жашаган жериңиз, жынысыңыз, социалдык статусуңуз эмне болсо болсун, жалпы дүйнөлүк Куран хатимине катышып, жамааттагы берекелүү соопко сиз да ортоктош болуңуз”."Эй мусулмандар! \t\t \n\n Аллахтын китеби Куранды бары-жогуңар менен кармангыла! Эч качан бөлүнүп-жарылбагыла!" (Али Имран 103)',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }
}
