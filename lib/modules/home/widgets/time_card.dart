import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:hatim/l10n/l10.dart';
import 'package:hatim/modules/modules.dart';

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
      descriptioText: context.l10n.homeMotivationTime,
      valueText: DateFormat('mm:ss').format(dateTime),
    );
  }
}
