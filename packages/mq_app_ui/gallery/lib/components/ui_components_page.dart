import 'package:flutter/material.dart';

class UiComponentsPage extends StatefulWidget {
  const UiComponentsPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(
      builder: (_) => const UiComponentsPage(),
    );
  }

  @override
  State<UiComponentsPage> createState() => _UiComponentsPageState();
}

class _UiComponentsPageState extends State<UiComponentsPage> {
  String dropdownValue = 'English';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('UI Components'),
      ),
      body: ListView(
        padding: const EdgeInsets.only(left: 16, right: 16),
        children: [
          const SizedBox(height: 16),
          Text(
            'Dropdown Button Form Field',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField(
            value: dropdownValue,
            icon: const Icon(Icons.keyboard_arrow_down),
            alignment: AlignmentDirectional.center,
            decoration: InputDecoration(
              labelText: 'Please select a language',
              prefixIcon: Icon(
                Icons.translate,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            items: ['English', 'Turkish', 'Kyrgyz'].map((value) {
              return DropdownMenuItem(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (Object? value) {},
          ),
          const SizedBox(height: 26),
          // Text(
          //   'Text Field',
          //   style: Theme.of(context).textTheme.bodyLarge,
          // ),
        ],
      ),
    );
  }
}
