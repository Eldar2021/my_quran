import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_quran/core/core.dart';
import 'package:my_quran/modules/modules.dart';

class ChooseContinentView extends StatelessWidget {
  const ChooseContinentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Шаар тандоо')),
      body: BlocProvider(
        create: (context) => context.read<NamazTimeCubit>()..getContinents(),
        child: BlocBuilder<NamazTimeCubit, NamazTimeState>(
          builder: (context, state) {
            if (state.status == FetchStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state.status == FetchStatus.success) {
              final continentsList = state.continentsEntity?.list;
              if (continentsList == null || continentsList.isEmpty) {
                return const Center(child: Text('No continents found.'));
              }

              return ListView.builder(
                itemCount: continentsList.length,
                itemBuilder: (context, index) {
                  final continent = continentsList[index];
                  return ListTile(
                    title: Text(continent.title ?? 'Unknown'),
                    onTap: () {
                      Navigator.push<RegionsView>(
                        context,
                        MaterialPageRoute<RegionsView>(
                          builder: (context) => RegionsView(continentId: continent.id),
                        ),
                      );
                    },
                  );
                },
              );
            } else if (state.status == FetchStatus.error) {
              return const Center(child: Text('Error getting namaz times.'));
            }
            return const Center(child: Text('Unexpected state.'));
          },
        ),
      ),
    );
  }
}
