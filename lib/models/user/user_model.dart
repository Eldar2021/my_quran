class User {
  const User({
    this.token = 'token',
    this.name = 'name',
    required this.gender,
  });

  final String token;
  final String name;
  final Gender gender;

  User copyWith({String? token, String? name, Gender? gender}) {
    return User(
      token: token ?? this.token,
      name: name ?? this.name,
      gender: gender ?? this.gender,
    );
  }
}

enum Gender { male, female }
