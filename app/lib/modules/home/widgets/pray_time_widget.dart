import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mq_app_ui/mq_app_ui.dart';
import 'package:my_quran/l10n/l10.dart';
import 'package:my_quran/modules/modules.dart';

class MqSalaahTimeWidget extends StatelessWidget {
  const MqSalaahTimeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: BlocConsumer<LocationCubit, LocationState>(
        listener: (BuildContext context, LocationState state) {},
        builder: (context, state) {
          return MqSalaahCard(
            fajrLabel: context.l10n.fajr,
            zuhrLabel: context.l10n.zuhr,
            asrLabel: context.l10n.asr,
            maghribLabel: context.l10n.maghrib,
            ishaLabel: context.l10n.isya,
            fajrTime: '',
            zuhrTime: '',
            asrTime: '',
            maghribTime: '',
            ishaTime: '',
            fajrActive: true,
            zuhrActive: true,
            asrActive: true,
            maghribActive: true,
            ishaActive: true,
            currentTime: DateFormat('HH:mm').format(DateTime.now()),
            locationLabel: state.locationName,
            location: state.timeZoneLocation,
            onLocationPressed: () {},
          );
        },
      ),
    );
  }
}
