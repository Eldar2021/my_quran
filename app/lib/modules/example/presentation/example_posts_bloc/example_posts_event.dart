part of 'example_posts_bloc.dart';

@immutable
sealed class ExamplePostsEvent {}

@immutable
final class ExamplePostsGetEvent extends ExamplePostsEvent {}
