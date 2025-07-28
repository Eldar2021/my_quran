import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mq_app_ui/mq_app_ui.dart';

class UiComponentsPage extends StatefulWidget {
  const UiComponentsPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const UiComponentsPage());
  }

  @override
  State<UiComponentsPage> createState() => _UiComponentsPageState();
}

class _UiComponentsPageState extends State<UiComponentsPage> {
  String dropdownValue = 'English';
  AppUiGender gender = AppUiGender.male;
  bool enableAzan = true;
  double sliderValue = 0.4;
  int bottomIndex = 0;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final prTextTheme = Theme.of(context).primaryTextTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(title: const Text('UI Components')),
      body: ListView(
        padding: const EdgeInsets.only(left: 16, right: 16),
        children: [
          const SizedBox(height: 16),
          Text('Dropdown Button Form Field', style: textTheme.bodyLarge),
          const SizedBox(height: 16),
          LanguageDropdownButtonFormField<String>(
            value: dropdownValue,
            items: const ['English', 'Turkish', 'Kyrgyz'],
            labelText: 'Please select a language',
            itemBuilder: (value) {
              return DropdownMenuItem(value: value, child: Text(value ?? ''));
            },
          ),
          const SizedBox(height: 26),
          Text('Pin Field', style: textTheme.bodyLarge),
          const SizedBox(height: 8),
          const PinputWidget(),
          const SizedBox(height: 26),
          Text('Read Theme items', style: textTheme.bodyLarge),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              OutlineThemeItem(
                backgroundColor: AppColors.white,
                foregroundColor: AppColors.black,
                borderColor: colorScheme.onSurface,
              ),
              OutlineThemeItem(
                backgroundColor: AppColors.papayaWhip,
                foregroundColor: AppColors.black,
                borderColor: colorScheme.primary,
              ),
              OutlineThemeItem(backgroundColor: colorScheme.onSurface, foregroundColor: colorScheme.surface),
              OutlineThemeItem(backgroundColor: colorScheme.scrim, foregroundColor: colorScheme.surface),
            ],
          ),
          const SizedBox(height: 26),
          Text('Gender Redio Widget', style: textTheme.bodyLarge),
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
          const SizedBox(height: 26),
          Text('Elevated Buttons', style: prTextTheme.bodyLarge),
          const SizedBox(height: 8),
          ElevatedButton(onPressed: () {}, child: const Text('Get started')),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () {},
            child: CupertinoActivityIndicator(color: colorScheme.onPrimary),
          ),
          const SizedBox(height: 8),
          const ElevatedButton(onPressed: null, child: Text('Get started')),
          const SizedBox(height: 26),
          Text('Switch', style: prTextTheme.bodyLarge),
          const SizedBox(height: 8),
          SwitchListTile(
            value: enableAzan,
            title: const Text('Azaan Alarm'),
            onChanged: (v) {
              setState(() {
                enableAzan = v;
              });
            },
          ),
          SwitchListTile(
            value: !enableAzan,
            title: const Text('Azaan Alarm'),
            onChanged: (v) {
              setState(() {
                enableAzan = v;
              });
            },
          ),
          const SizedBox(height: 26),
          Text('Text field', style: prTextTheme.bodyLarge),
          const SizedBox(height: 8),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Enter your email',
              prefixIcon: Icon(Icons.email, size: 28),
              hintText: 'Enter email',
            ),
          ),
          const SizedBox(height: 26),
          Text('Outline bottons', style: prTextTheme.bodyLarge),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              OutlinedButton(onPressed: () {}, child: const Text('Read')),
              OutlinedButton.icon(
                onPressed: () {},
                label: const Text('Read'),
                iconAlignment: IconAlignment.end,
                icon: Assets.icons.book.svg(colorFilter: ColorFilter.mode(colorScheme.primary, BlendMode.srcIn)),
              ),
              OutlinedButton.icon(
                onPressed: null,
                label: const Text('Read'),
                iconAlignment: IconAlignment.end,
                icon: Assets.icons.book.svg(colorFilter: ColorFilter.mode(colorScheme.outline, BlendMode.srcIn)),
              ),
              OutlinedButton(
                onPressed: () {},
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: CupertinoActivityIndicator(color: colorScheme.primary),
                ),
              ),
            ],
          ),
          const SizedBox(height: 26),
          Text('Lieaner progress', style: prTextTheme.bodyLarge),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            borderRadius: BorderRadius.circular(99),
            backgroundColor: colorScheme.outline.withValues(alpha: 0.1),
            minHeight: 6,
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: 0.02,
            borderRadius: BorderRadius.circular(99),
            backgroundColor: colorScheme.outline.withValues(alpha: 0.1),
            minHeight: 6,
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: 0.5,
            borderRadius: BorderRadius.circular(99),
            backgroundColor: colorScheme.outline.withValues(alpha: 0.1),
            minHeight: 6,
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: 1,
            borderRadius: BorderRadius.circular(99),
            backgroundColor: colorScheme.outline.withValues(alpha: 0.1),
            minHeight: 6,
          ),
          const SizedBox(height: 26),
          Text('Sliders', style: prTextTheme.bodyLarge),
          const SizedBox(height: 8),
          Slider.adaptive(
            value: sliderValue,
            onChanged: (v) {
              setState(() {
                sliderValue = v;
              });
            },
          ),
          Slider(
            value: sliderValue,
            inactiveColor: colorScheme.outline.withValues(alpha: 0.2),
            onChanged: (v) {
              setState(() {
                sliderValue = v;
              });
            },
          ),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 7),
              trackShape: const RoundedRectSliderTrackShape(),
            ),
            child: Slider(
              value: sliderValue,
              inactiveColor: colorScheme.outline.withValues(alpha: 0.2),
              thumbColor: colorScheme.onSecondary,
              onChanged: (v) {
                setState(() {
                  sliderValue = v;
                });
              },
            ),
          ),
          const SizedBox(height: 26),
          Text('List Tile', style: prTextTheme.bodyLarge),
          const SizedBox(height: 8),
          ListTile(
            leading: CircleAvatar(
              radius: 17,
              backgroundColor: colorScheme.onInverseSurface,
              child: Assets.icons.translate.svg(colorFilter: ColorFilter.mode(colorScheme.primary, BlendMode.srcIn)),
            ),
            title: const Text('Custom app'),
            titleTextStyle: prTextTheme.titleLarge,
            trailing: const Icon(Icons.arrow_forward_ios),
          ),
          const SizedBox(height: 300),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 1,
        onTap: (int index) {
          setState(() {
            bottomIndex = index;
          });
        },
        currentIndex: bottomIndex,
        items: [
          BottomNavigationBarItem(
            activeIcon: Assets.icons.quran.svg(colorFilter: ColorFilter.mode(colorScheme.primary, BlendMode.srcIn)),
            icon: Assets.icons.quran.svg(colorFilter: ColorFilter.mode(colorScheme.outline, BlendMode.srcIn)),
            label: 'Quran',
          ),
          BottomNavigationBarItem(
            activeIcon: Assets.icons.prayingMan.svg(
              width: 27,
              colorFilter: ColorFilter.mode(colorScheme.primary, BlendMode.srcIn),
            ),
            icon: Assets.icons.prayingMan.svg(
              width: 27,
              colorFilter: ColorFilter.mode(colorScheme.outline, BlendMode.srcIn),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            activeIcon: Assets.icons.listenQuran.svg(
              colorFilter: ColorFilter.mode(colorScheme.primary, BlendMode.srcIn),
            ),
            icon: Assets.icons.listenQuran.svg(colorFilter: ColorFilter.mode(colorScheme.outline, BlendMode.srcIn)),
            label: 'Messages',
          ),
        ],
      ),
    );
  }
}
