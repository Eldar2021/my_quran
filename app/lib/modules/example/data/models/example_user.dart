class ExampleUser {
  const ExampleUser({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.phone,
    required this.website,
  });

  factory ExampleUser.fromJson(Map<String, dynamic> map) {
    return ExampleUser(
      id: map['id'] as int,
      name: map['name'] as String,
      username: map['username'] as String,
      email: map['email'] as String,
      phone: map['phone'] as String,
      website: map['website'] as String,
    );
  }

  final int id;
  final String name;
  final String username;
  final String email;
  final String phone;
  final String website;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'username': username,
      'email': email,
      'phone': phone,
      'website': website,
    };
  }
}
