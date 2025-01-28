import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mq_app_ui/mq_app_ui.dart';
import 'package:my_quran/l10n/l10.dart';
import 'package:my_quran/modules/modules.dart';
import 'package:my_quran/utils/show/alerts.dart';

class MqSalaahTimeWidget extends StatefulWidget {
  const MqSalaahTimeWidget({super.key});

  @override
  State<MqSalaahTimeWidget> createState() => _MqSalaahTimeWidgetState();
}

class _MqSalaahTimeWidgetState extends State<MqSalaahTimeWidget> {
  late final Stream<(String, String)> _nexPreyer;

  @override
  void initState() {
    _nexPreyer = Stream.periodic(
      const Duration(seconds: 1),
      (x) => ('Куптанга', '11саат : 10 мин'),
    );
    super.initState();
  }

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
            nexPreyer: _nexPreyer,
            fajrLabel: context.l10n.fajr,
            zuhrLabel: context.l10n.zuhr,
            asrLabel: context.l10n.asr,
            maghribLabel: context.l10n.maghrib,
            ishaLabel: context.l10n.isya,
            fajrTime: '6:48',
            zuhrTime: '6:48',
            asrTime: '6:48',
            maghribTime: '6:48',
            ishaTime: '6:48',
            fajrActive: true,
            zuhrActive: true,
            asrActive: true,
            maghribActive: true,
            ishaActive: true,
            locationLabel: state.locationName,
            location: state.timeZoneLocation,
            onLocationPressed: () {},
          );
        },
      ),
    );
  }

  void _onEventNewLocation(BuildContext context, String newLocation) {
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
