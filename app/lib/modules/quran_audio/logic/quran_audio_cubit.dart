import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'quran_audio_state.dart';

class QuranAudioCubit extends Cubit<QuranAudioState> {
  QuranAudioCubit() : super(const QuranAudioState(001));
}
