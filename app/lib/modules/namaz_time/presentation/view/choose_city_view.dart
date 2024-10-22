import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_quran/core/core.dart';
import 'package:my_quran/modules/modules.dart';

class CityView extends StatelessWidget {
  const CityView({required this.regionId, super.key});

  final int regionId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('City'),
      ),
      body: BlocProvider(
        create: (context) => context.read<NamazTimeCubit>()..getRegions(regionId),
        child: BlocBuilder<NamazTimeCubit, NamazTimeState>(
          builder: (context, state) {
            if (state.status == FetchStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state.status == FetchStatus.error) {
              return const Center(child: Text('Error fetching regions.'));
            } else if (state.status == FetchStatus.success) {
              final regions = state.regionsEntity?.list ?? [];

              return ListView.builder(
                itemCount: regions.length,
                itemBuilder: (context, index) {
                  final region = regions[index];
                  return ListTile(
                    title: Text(region.title ?? ''),
                    onTap: () {
                      Navigator.push<ChooseContinentView>(
                        context,
                        MaterialPageRoute<ChooseContinentView>(
                          builder: (context) => NamazTimeView(cityId: region.id),
                        ),
                      );
                      // context.read<NamazTimeCubit>().getRegions(region.id);
                    },
                  );
                },
              );
            }
            return const Center(child: Text('No regions found.'));
          },
        ),
      ),
    );
  }
}
