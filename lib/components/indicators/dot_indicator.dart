import 'dart:math';

import 'package:flutter/material.dart';

class DotsIndicator extends AnimatedWidget {
  const DotsIndicator({
    required this.controller,
    required this.itemCount,
    required this.activeColor,
    required this.disactiveColor,
    this.dotSize = 5,
    this.space = 20,
    this.maxZoom = 1.5,
    super.key,
  }) : super(listenable: controller);

  final PageController controller;
  final int itemCount;
  final Color activeColor;
  final Color disactiveColor;
  final double dotSize;
  final double maxZoom;
  final double space;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List<Widget>.generate(itemCount, (index) {
        return Dot(
          controller: controller,
          index: index,
          activeColor: activeColor,
          disactiveColor: disactiveColor,
          maxZoom: maxZoom,
          space: space,
          dotSize: dotSize,
        );
      }),
    );
  }
}

class Dot extends StatelessWidget {
  const Dot({
    required this.controller,
    required this.index,
    required this.activeColor,
    required this.disactiveColor,
    required this.maxZoom,
    required this.space,
    required this.dotSize,
    super.key,
  });

  final PageController controller;
  final int index;
  final Color activeColor;
  final Color disactiveColor;
  final double maxZoom;
  final double space;
  final double dotSize;

  @override
  Widget build(BuildContext context) {
    final selectedness = Curves.easeOut.transform(
      max(0, 1.0 - ((controller.page ?? controller.initialPage) - index).abs()),
    );
    final zoom = 1.0 + (maxZoom - 1.0) * selectedness;
    return SizedBox(
      width: space,
      child: Center(
        child: CircleAvatar(
          radius: dotSize * zoom,
          backgroundColor: zoom > 1 ? activeColor : disactiveColor,
        ),
      ),
    );
  }
}
