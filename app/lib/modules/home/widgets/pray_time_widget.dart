import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mq_app_ui/mq_app_ui.dart';
import 'package:my_quran/components/components.dart';
import 'package:my_quran/l10n/l10.dart';
import 'package:my_quran/modules/modules.dart';
import 'package:my_quran/utils/show/alerts.dart';

class MqSalaahTimeWidget extends StatelessWidget {
  const MqSalaahTimeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: BlocConsumer<LocationCubit, LocationState>(
        listener: (BuildContext context, LocationState state) {
          final eventState = state.eventState;
          if (eventState is LocationEventNewLocation) {
            _onEventNewLocation(context, eventState.newLocationName);
          }
        },
        builder: (context, state) {
          return MqSalaahCard(
            fajrLabel: context.l10n.fajr,
            sunriseLabel: context.l10n.sunrise,
            zuhrLabel: context.l10n.zuhr,
            asrLabel: context.l10n.asr,
            maghribLabel: context.l10n.maghrib,
            ishaLabel: context.l10n.isya,
            tahajjudLabel: context.l10n.tahajjud,
            qiblaCompassWarning: context.l10n.qiblaCompassWarning,
            locationLabel: state.locationName,
            location: state.timeZoneLocation,
            onLocationPressed: () {},
            lat: state.position.latitude,
            lon: state.position.longitude,
            extraWidget: QiblaCompass(
              latitude: state.position.latitude,
              longitude: state.position.longitude,
            ),
          );
        },
      ),
    );
  }

  void _onEventNewLocation(
    BuildContext context,
    String newLocation,
  ) {
    AppAlert.showUpdateLocation(
      context: context,
      newLocation: newLocation,
      onConfirm: (ctx) {
        context.read<LocationCubit>().updateLocation();
        Navigator.pop(ctx);
      },
      onCancel: Navigator.pop,
    );
  }
}
