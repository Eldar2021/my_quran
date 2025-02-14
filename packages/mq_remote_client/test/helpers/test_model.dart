final class TestModel {
  const TestModel({required this.userId, required this.id, required this.title, required this.body});

  factory TestModel.fromJson(Map<String, dynamic> json) {
    return TestModel(
      userId: json['userId'] as int,
      id: json['id'] as int,
      title: json['title'] as String,
      body: json['body'] as String,
    );
  }
  final int userId;
  final int id;
  final String title;
  final String body;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{'userId': userId, 'id': id, 'title': title, 'body': body};
  }
}
