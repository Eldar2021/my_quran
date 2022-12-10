class ServerExc implements Exception {
  const ServerExc(this.massage);

  final String? massage;

  @override
  String toString() => massage ?? 'Server Exception';
}
