class ExamplePost {
  const ExamplePost({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  factory ExamplePost.fromJson(Map<String, dynamic> map) {
    return ExamplePost(
      userId: map['userId'] as int,
      id: map['id'] as int,
      title: map['title'] as String,
      body: map['body'] as String,
    );
  }

  final int userId;
  final int id;
  final String title;
  final String body;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'userId': userId,
      'id': id,
      'title': title,
      'body': body,
    };
  }
}
