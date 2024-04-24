part of 'login_cubit.dart';

class LoginState extends Equatable {
  const LoginState(this.value, {this.isPrivacyPolicyChecked = false});

  final int value;
  final bool isPrivacyPolicyChecked;

  @override
  List<Object?> get props => [value, isPrivacyPolicyChecked];

  LoginState copyWith({int? value, bool? isPrivacyPolicyChecked}) {
    return LoginState(
      value ?? this.value,
      isPrivacyPolicyChecked: isPrivacyPolicyChecked ?? this.isPrivacyPolicyChecked,
    );
  }
}
