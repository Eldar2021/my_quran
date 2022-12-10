class NetworkExc implements Exception {
  const NetworkExc(this.massage);

  final String? massage;

  @override
  String toString() => massage ?? 'Network Exception';
}
