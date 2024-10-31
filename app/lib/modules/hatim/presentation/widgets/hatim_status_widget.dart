import 'package:flutter/material.dart';

class HatimStatusWidget extends StatelessWidget {
  const HatimStatusWidget({
    required this.text,
    required this.color,
    super.key,
  });

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text('$text ', style: const TextStyle(fontSize: 12)),
        Container(
          width: 18,
          height: 18,
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            border: Border.all(color: color),
          ),
          child: CircleAvatar(
            backgroundColor: color,
          ),
        ),
      ],
    );
  }
}
