import 'package:flutter/material.dart';
import 'package:mq_app_ui/mq_app_ui.dart';

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
  AppUiGender gender = AppUiGender.male;

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
          LanguageDropdownButtonFormField<String>(
            value: dropdownValue,
            items: const ['English', 'Turkish', 'Kyrgyz'],
            labelText: 'Please select a language',
            itemBuilder: (value) {
              return DropdownMenuItem(
                value: value,
                child: Text(value ?? ''),
              );
            },
          ),
          const SizedBox(height: 26),
          Text(
            'Pin Field',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 8),
          const PinputWidget(),
          const SizedBox(height: 26),
          Text(
            'Read Theme items',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              OutlineThemeItem(
                backgroundColor: AppColors.white,
                foregroundColor: AppColors.black,
                borderColor: Theme.of(context).colorScheme.onSurface,
              ),
              OutlineThemeItem(
                backgroundColor: AppColors.papayaWhip,
                foregroundColor: AppColors.black,
                borderColor: Theme.of(context).colorScheme.primary,
              ),
              OutlineThemeItem(
                backgroundColor: Theme.of(context).colorScheme.onSurface,
                foregroundColor: Theme.of(context).colorScheme.surface,
              ),
              OutlineThemeItem(
                backgroundColor: Theme.of(context).colorScheme.scrim,
                foregroundColor: Theme.of(context).colorScheme.surface,
              ),
            ],
          ),
          const SizedBox(height: 26),
          Text(
            'Gender Redio Widget',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          // SvgPicture.asset(
          //   'assets/icons/book.svg',
          //   color: Theme.of(context).colorScheme.primary,
          // ),
          GenderRedioWidget(
            gender: gender,
            title: 'Male',
            onChanged: (p0) {
              setState(() {
                gender = p0!;
              });
            },
          ),
          GenderRedioWidget(
            gender: gender,
            itemIsMale: false,
            title: 'Female',
            onChanged: (p0) {
              setState(() {
                gender = p0!;
              });
            },
          ),
        ],
      ),
    );
  }
}
