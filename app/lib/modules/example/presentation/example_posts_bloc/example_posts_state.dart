part of 'example_posts_bloc.dart';

@immutable
sealed class ExamplePostsState {
  const ExamplePostsState();
}

@immutable
final class ExamplePostsInitial extends ExamplePostsState {
  const ExamplePostsInitial();
}

@immutable
final class ExamplePostsLoading extends ExamplePostsState {
  const ExamplePostsLoading();
}

@immutable
final class ExamplePostsSuccess extends ExamplePostsState {
  const ExamplePostsSuccess(this.data);

  final List<ExamplePost> data;
}

@immutable
final class ExamplePostsError extends ExamplePostsState {
  const ExamplePostsError(this.error);

  final Object error;
}
