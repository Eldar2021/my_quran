part of 'mq_story_cubit.dart';

@immutable
final class MqStoryState extends Equatable {
  const MqStoryState({
    this.status = FetchStatus.loading,
    this.stories,
  });

  final List<MqStoryEntity>? stories;
  final FetchStatus status;

  @override
  List<Object?> get props => [stories, status];

  List<MqStoryEntity> get getStories => stories ?? [];
}
