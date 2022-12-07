part of 'auth_cubit.dart';

class AuthState extends Equatable {
  const AuthState({this.user, this.gender = Gender.male});

  final User? user;
  final Gender gender;

  @override
  List<Object?> get props => [user, gender];

  AuthState copyWith({User? user, Gender? gender}) {
    return AuthState(user: user ?? this.user, gender: gender ?? this.gender);
  }
}
