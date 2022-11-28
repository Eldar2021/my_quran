import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hatim/app/app.dart';
import 'package:hatim/modules/modules.dart';

void main() {
  runApp(
    BlocProvider(
      create: (context) => SettingsCubit(),
      
      child: const MyApp(),
    ),
  );
}
