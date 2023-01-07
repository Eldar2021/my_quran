part of 'auth_cubit.dart';

class AuthState extends Equatable {
  const AuthState({this.user});

  final User? user;

  @override
  List<Object?> get props => [user];

  AuthState copyWith({User? user}) {
    return AuthState(user: user ?? this.user);
  }
}
