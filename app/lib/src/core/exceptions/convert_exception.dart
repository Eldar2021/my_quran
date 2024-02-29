/// Convert Exception
class ConvertExc implements Exception {
  const ConvertExc({this.message});

  final String? message;

  @override
  String toString() => message ?? 'Convert Exception';
}
