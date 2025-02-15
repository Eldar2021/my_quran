import 'package:flutter/material.dart';
import 'package:mq_app_ui/mq_app_ui.dart';

class BgImageBodyPage extends StatelessWidget {
  const BgImageBodyPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const BgImageBodyPage());
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithBgImage(appBar: AppBar(elevation: 0, title: const Text('Body')));
  }
}
