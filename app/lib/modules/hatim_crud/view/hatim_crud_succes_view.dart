import 'package:flutter/material.dart';

class HatimCrudSuccesView extends StatelessWidget {
  const HatimCrudSuccesView({
    required this.title,
    this.description,
    super.key,
  });

  final String title;
  final String? description;

  static void show({
    required BuildContext context,
    required String title,
    String? description,
  }) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute<void>(
        fullscreenDialog: true,
        builder: (context) => HatimCrudSuccesView(
          title: title,
          description: description,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hatim Crud Succes'),
      ),
    );
  }
}
