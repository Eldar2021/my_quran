import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hatim/modules/modules.dart';
import 'package:intl/intl.dart';

class TimeCard extends StatefulWidget {
  const TimeCard({super.key});

  @override
  State<TimeCard> createState() => _TimeCardState();
}

class _TimeCardState extends State<TimeCard> {
  DateTime dateTime = DateTime.now();

  @override
  void initState() {
    super.initState();
    Timer.periodic(
      const Duration(seconds: 1),
      (Timer t) {
        if (mounted) {
          setState(() {
            dateTime = DateTime.now();
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return HomeCard(
      titleText: DateFormat('dd/MM/yyy').format(dateTime),
      descriptioText:
          'Applying VisualDensity allows you to expand or contract the height of list tile. VisualDensity is',
      valueText: DateFormat('mm:ss').format(dateTime),
    );
  }
}
