part of 'login_cubit.dart';

@immutable
sealed class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

@immutable
final class LoginInitial extends LoginState {
  const LoginInitial();
}

@immutable
final class LoginLoading extends LoginState {
  const LoginLoading();
}

@immutable
final class LoginSuccess extends LoginState {
  const LoginSuccess(this.data);

  final AuthModel data;

  @override
  List<Object> get props => [data];
}

@immutable
final class LoginError extends LoginState {
  const LoginError(this.error);

  final Object error;

  @override
  List<Object> get props => [error];
}
