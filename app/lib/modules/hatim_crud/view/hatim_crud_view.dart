import 'package:flutter/material.dart';

class HatimCrudView extends StatelessWidget {
  const HatimCrudView(this.hatimId, {super.key});

  final String? hatimId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hatim Crud $hatimId'),
      ),
    );
  }
}
