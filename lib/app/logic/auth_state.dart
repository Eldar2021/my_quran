part of 'auth_cubit.dart';

class AuthState extends Equatable {
  const AuthState({this.user, this.totalHatim, this.totalRead});

  final User? user;
  final int? totalHatim;
  final int? totalRead;

  @override
  List<Object?> get props => [user, totalRead];

  AuthState copyWith({User? user, int? totalHatim, int? totalRead}) {
    return AuthState(
      user: user ?? this.user,
      totalHatim: totalHatim ?? this.totalHatim,
      totalRead: totalRead ?? this.totalRead,
    );
  }
}
