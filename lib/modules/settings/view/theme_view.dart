import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatim/app/app.dart';
import 'package:hatim/theme/custom/custom_theme.dart';

class AppThemeView extends StatelessWidget {
  const AppThemeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AppThemes'),
      ),
      body: BlocBuilder<AppCubit, AppState>(
        builder: (context, state) {
          return ListView.builder(
            itemCount: AppThemes.values.length,
            itemBuilder: (context, index) {
              final itemAppTheme = AppThemes.values[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                child: Card(
                  elevation: 5,
                  color: appThemeData[itemAppTheme]!.primaryContainer,
                  child: ListTile(
                    onTap: () {
                      context.read<AppCubit>().changeTheme(itemAppTheme);
                    },
                    title: Text(
                      itemAppTheme.toString(),
                      style: appThemeData[itemAppTheme]!.textTheme?.bodyMedium,
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
