part of 'example_users_bloc.dart';

@immutable
sealed class ExampleUsersEvent {}

@immutable
final class ExampleUsersGetEvent extends ExampleUsersEvent {}
