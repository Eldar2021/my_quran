import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mq_app_ui/mq_app_ui.dart';
import 'package:mq_quran_repository/mq_quran_repository.dart';
import 'package:my_quran/modules/modules.dart';

class QuranBySurahView extends StatelessWidget {
  const QuranBySurahView(this.surahNumber, {super.key});

  final int surahNumber;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => QuranBookThemeCubit(
            readThemeRepository: context.read<ReadThemeRepository>(),
          )..initializeTheme(),
        ),
        BlocProvider(
          create: (context) => QuranBookBySurahCubit(
            repository: context.read<MqQuranRepository>(),
            surahNumber: surahNumber,
          ),
        ),
      ],
      child: const _QuranBySurahView(),
    );
  }
}

class _QuranBySurahView extends StatefulWidget {
  const _QuranBySurahView();

  @override
  State<_QuranBySurahView> createState() => __QuranBySurahViewState();
}

class __QuranBySurahViewState extends State<_QuranBySurahView> {
  late final SurahEntity _surahEntity;

  @override
  void initState() {
    _surahEntity = context.read<QuranBookBySurahCubit>().getSurahData();
    context.read<QuranBookBySurahCubit>().getData('uthmanic');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_surahEntity.name),
      ),
    );
  }
}
