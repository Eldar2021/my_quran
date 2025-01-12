import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:mq_crashlytics/mq_crashlytics.dart';
import 'package:mq_home_repository/mq_home_repository.dart';
import 'package:my_quran/core/core.dart';

part 'mq_story_state.dart';

class MqStoryCubit extends Cubit<MqStoryState> {
  MqStoryCubit(this.homeRepository) : super(const MqStoryState());

  final MqHomeRepository homeRepository;

  Future<void> getStories(String language) async {
    try {
      emit(const MqStoryState());
      final stories = await homeRepository.getStories(language);
      emit(MqStoryState(status: FetchStatus.success, stories: stories));
    } catch (e, s) {
      MqCrashlytics.report(e, s);
      emit(const MqStoryState(status: FetchStatus.error));
    }
  }
}
