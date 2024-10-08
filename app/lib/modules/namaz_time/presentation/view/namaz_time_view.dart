import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_quran/core/core.dart';
import 'package:my_quran/modules/modules.dart';

class NamazTimeView extends StatelessWidget {
  const NamazTimeView({required this.cityId, super.key});

  final int cityId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Today's Namaz Times"),
      ),
      body: BlocProvider(
        create: (context) => context.read<NamazTimeCubit>()..getNamazTimes(cityId),
        child: BlocBuilder<NamazTimeCubit, NamazTimeState>(
          builder: (context, state) {
            if (state.status == FetchStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state.status == FetchStatus.error) {
              return const Center(child: Text('Error fetching Namaz times.'));
            } else if (state.status == FetchStatus.success) {
              final namazTime = state.namazTimesModel;
              final todayTimes = namazTime?.getTodaysTimes();

              if (todayTimes == null) {
                return const Center(child: Text('No Namaz times available for today.'));
              }
              final prayerNames = [
                'Fajr',
                'Sunrise',
                'Dhuhr',
                'Asr',
                'Maghrib',
                'Isha',
              ];

              return ListView.builder(
                itemCount: prayerNames.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(prayerNames[index]),
                    trailing: Text(todayTimes[index]),
                  );
                },
              );
            }
            return const Center(child: Text('No Namaz times available.'));
          },
        ),
      ),
    );
  }
}
