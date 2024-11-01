import 'package:flutter/material.dart';

class ProgressRowWidget extends StatelessWidget {
  const ProgressRowWidget({
    required this.count,
    required this.label,
    required this.color,
    super.key,
  });

  final int count;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            text: '$count ',
            style: const TextStyle(
              fontSize: 10,
              color: Color(0xff1C274C),
            ),
            children: [
              TextSpan(
                text: ' $label  ',
                style: const TextStyle(
                  color: Color(0xff666666),
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ),
        CircleAvatar(
          radius: 3.5,
          backgroundColor: color,
        ),
      ],
    );
  }
}
