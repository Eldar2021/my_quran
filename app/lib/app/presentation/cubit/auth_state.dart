part of 'auth_cubit.dart';

class AuthState extends Equatable {
  const AuthState({this.user, this.exception});

  final UserEntity? user;
  final Exception? exception;

  @override
  List<Object?> get props => [user, exception];

  AuthState copyWith({UserEntity? user, Exception? exception}) {
    return AuthState(
      user: user ?? this.user,
      exception: exception ?? this.exception,
    );
  }
}
