part of 'example_users_bloc.dart';

@immutable
sealed class ExampleUsersState {
  const ExampleUsersState();
}

@immutable
final class ExampleUsersInitial extends ExampleUsersState {
  const ExampleUsersInitial();
}

@immutable
final class ExampleUsersLoading extends ExampleUsersState {
  const ExampleUsersLoading();
}

@immutable
final class ExampleUsersSuccess extends ExampleUsersState {
  const ExampleUsersSuccess(this.data);

  final List<ExampleUser> data;
}

@immutable
final class ExampleUsersError extends ExampleUsersState {
  const ExampleUsersError(this.error);

  final Object error;
}
