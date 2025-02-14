import 'package:flutter/material.dart';
import 'package:gallery/colors/theme_colors_view.dart';
import 'package:mq_app_ui/mq_app_ui.dart';

class AppColorsView extends StatelessWidget {
  const AppColorsView({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const AppColorsView());
  }

  @override
  Widget build(BuildContext context) {
    const colorItems = [
      ColorSquare(name: 'Tomato', color: AppColors.tomato),
      ColorSquare(name: 'Tomato2', color: AppColors.tomato2),
      ColorSquare(name: 'Tomato3', color: AppColors.tomato3),
      ColorSquare(name: 'Transparent', color: AppColors.transparent),
      ColorSquare(name: 'Darkslateblue', color: AppColors.darkslateblue),
      ColorSquare(name: 'Cornflowerblue', color: AppColors.cornflowerblue),
      ColorSquare(name: 'Dodgerblue', color: AppColors.dodgerblue),
      ColorSquare(name: 'Transparent', color: AppColors.transparent),
      ColorSquare(name: 'White', color: AppColors.white),
      ColorSquare(name: 'Whitesmoke', color: AppColors.whitesmoke),
      ColorSquare(name: 'Ghostwhite', color: AppColors.ghostwhite),
      ColorSquare(name: 'Darkred', color: AppColors.darkred),
      ColorSquare(name: 'Mediumseagreen', color: AppColors.mediumseagreen),
      ColorSquare(name: 'Goldenrod', color: AppColors.goldenrod),
      ColorSquare(name: 'Black', color: AppColors.black),
      ColorSquare(name: 'Black2', color: AppColors.black2),
      ColorSquare(name: 'Black3', color: AppColors.black3),
      ColorSquare(name: 'Black4', color: AppColors.black4),
      ColorSquare(name: 'Black5', color: AppColors.black5),
      ColorSquare(name: 'Darkslategray', color: AppColors.darkslategray),
      ColorSquare(name: 'Darkslategray2', color: AppColors.darkslategray2),
      ColorSquare(name: 'Slategray', color: AppColors.slategray),
      ColorSquare(name: 'Darkgray', color: AppColors.darkgray),
      ColorSquare(name: 'Gainsboro', color: AppColors.gainsboro),
      ColorSquare(name: 'PapayaWhip', color: AppColors.papayaWhip),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('App Colors')),
      body: GridView.builder(
        itemCount: colorItems.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
        itemBuilder: (_, index) => colorItems[index],
      ),
    );
  }
}
